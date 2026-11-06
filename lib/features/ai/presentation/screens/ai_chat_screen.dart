import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/aqua_theme.dart';
import '../../../../core/widgets/aqua_widgets.dart';
import '../../../tank/presentation/controllers/tank_provider.dart';
import '../../domain/chat_message.dart';
import '../controllers/ai_providers.dart';
import '../widgets/report_ai_sheet.dart';
import '../../../share/presentation/share_actions.dart';
import '../../../subscription/presentation/controllers/subscription_providers.dart';
import '../../../subscription/presentation/paywall_screen.dart';

/// Chat with the AI assistant, optionally about one tank
class AiChatScreen extends ConsumerStatefulWidget {
  const AiChatScreen({super.key, this.tankId, this.tankName});

  /// Tank to discuss; null means general questions
  final int? tankId;
  final String? tankName;

  @override
  ConsumerState<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends ConsumerState<AiChatScreen> {
  final _input = TextEditingController();
  final _scroll = ScrollController();
  late int? _tankId = widget.tankId;
  late String? _tankName = widget.tankName;

  static const _tankSuggestions = [
    'How is my tank doing overall?',
    'What should I do this week?',
    'Is my stocking OK for this tank?',
    'Are all my fish compatible?',
  ];

  static const _generalSuggestions = [
    'How do I cycle a new tank?',
    'Why is my water cloudy?',
    'Best beginner plants?',
    'How often should I change water?',
  ];

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _send([String? text]) {
    final message = text ?? _input.text;
    if (message.trim().isEmpty) return;
    _input.clear();
    ref.read(chatControllerProvider(_tankId).notifier).send(message);
  }

  Future<void> _upgrade() async {
    final unlocked = await showPaywall(context, reason: PaywallReason.aiLimit);
    if (unlocked && mounted) {
      ref.read(chatControllerProvider(_tankId).notifier).retry();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final chat = ref.watch(chatControllerProvider(_tankId));
    final available = ref.watch(aiServiceProvider).isAvailable;
    final isPremium = ref.watch(isPremiumProvider);

    ref.listen(chatControllerProvider(_tankId), (previous, next) {
      if (previous?.messages.length != next.messages.length ||
          previous?.isSending != next.isSending) {
        _scrollToBottom();
      }
    });

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: _buildTitle(context),
        actions: [
          if (chat.messages.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined),
              tooltip: 'Clear conversation',
              onPressed: () =>
                  ref.read(chatControllerProvider(_tankId).notifier).clear(),
            ),
        ],
      ),
      body: Column(
        children: [
          if (!available) const _NotSetUpBanner(),
          Expanded(
            child: chat.messages.isEmpty
                ? _buildWelcome(context, enabled: available)
                : ListView.builder(
                    controller: _scroll,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    itemCount: chat.messages.length + (chat.isSending ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == chat.messages.length) {
                        return const _TypingBubble();
                      }
                      final message = chat.messages[index];
                      // The question this answer replied to, for share cards
                      final question =
                          index > 0 && chat.messages[index - 1].isUser
                          ? chat.messages[index - 1].text
                          : null;
                      return _MessageBubble(
                        message: message,
                        onShare: message.isUser || message.isError
                            ? null
                            : () => shareAiTip(
                                context,
                                answer: message.text,
                                question: question,
                                tankName: _tankName,
                              ),
                        onUpgrade: message.isQuota && !isPremium
                            ? _upgrade
                            : null,
                        onRetry: message.isError
                            ? () => ref
                                  .read(
                                    chatControllerProvider(_tankId).notifier,
                                  )
                                  .retry()
                            : null,
                      );
                    },
                  ),
          ),
          _InputBar(
            controller: _input,
            enabled: available && !chat.isSending,
            onSend: _send,
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final tanks = ref.watch(tanksStreamProvider).value ?? [];
    final textTheme = Theme.of(context).textTheme;

    return PopupMenuButton<int?>(
      tooltip: 'Choose tank',
      onSelected: (id) => setState(() {
        _tankId = id == -1 ? null : id;
        _tankName = tanks.where((t) => t.id == _tankId).firstOrNull?.name;
      }),
      itemBuilder: (context) => [
        const PopupMenuItem(value: -1, child: Text('General questions')),
        for (final tank in tanks)
          PopupMenuItem(
            value: tank.id,
            child: Text('${tank.tankType.icon}  ${tank.name}'),
          ),
      ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GradientIconTile(
            icon: Icons.auto_awesome_rounded,
            size: 34,
            gradient: AquaTheme.of(context).accentGradient,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('TankMind AI', style: textTheme.titleMedium),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        _tankName ?? 'General questions',
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down_rounded,
                      size: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcome(BuildContext context, {required bool enabled}) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final suggestions = _tankId == null
        ? _generalSuggestions
        : _tankSuggestions;

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
      children: [
        Center(
          child: GradientIconTile(
            icon: Icons.auto_awesome_rounded,
            size: 76,
            gradient: AquaTheme.of(context).accentGradient,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          _tankName == null
              ? 'Ask me anything about fishkeeping'
              : 'Ask me anything about $_tankName',
          textAlign: TextAlign.center,
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          _tankName == null
              ? 'Pick a tank above and I can use its readings, livestock and history.'
              : 'I can see its readings, livestock, plants, equipment and maintenance history.',
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 28),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 10,
          children: [
            for (final suggestion in suggestions)
              ActionChip(
                label: Text(suggestion),
                avatar: Icon(
                  Icons.bolt_rounded,
                  size: 16,
                  color: scheme.primary,
                ),
                onPressed: enabled ? () => _send(suggestion) : null,
              ),
          ],
        ),
      ],
    );
  }
}

class _NotSetUpBanner extends StatelessWidget {
  const _NotSetUpBanner();

  @override
  Widget build(BuildContext context) {
    final aqua = AquaTheme.of(context);
    return GlassCard(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      padding: const EdgeInsets.all(14),
      borderColor: aqua.caution.withValues(alpha: 0.4),
      child: Row(
        children: [
          Icon(Icons.cloud_off_rounded, color: aqua.caution),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              "The AI assistant isn't set up in this build yet. "
              'Everything else works as normal.',
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.message,
    this.onRetry,
    this.onUpgrade,
    this.onShare,
  });

  final ChatMessage message;
  final VoidCallback? onRetry;

  /// Opens a share card for this answer
  final VoidCallback? onShare;

  /// Shown instead of Retry when the daily limit was reached
  final VoidCallback? onUpgrade;

  @override
  Widget build(BuildContext context) {
    final aqua = AquaTheme.of(context);
    final scheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final isUser = message.isUser;
    const radius = Radius.circular(20);
    final shape = BorderRadius.only(
      topLeft: radius,
      topRight: radius,
      bottomLeft: isUser ? radius : const Radius.circular(6),
      bottomRight: isUser ? const Radius.circular(6) : radius,
    );

    final Widget content;
    if (isUser) {
      content = Text(
        message.text,
        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
      );
    } else if (message.isError) {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.error_outline_rounded, size: 18, color: aqua.danger),
              const SizedBox(width: 8),
              Expanded(child: Text(message.text)),
            ],
          ),
          if (onUpgrade != null) ...[
            const SizedBox(height: 10),
            GradientButton(
              label: 'Upgrade to Premium',
              icon: Icons.workspace_premium_rounded,
              gradient: aqua.accentGradient,
              onPressed: onUpgrade,
            ),
          ] else if (onRetry != null)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text('Retry'),
              ),
            ),
        ],
      );
    } else {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarkdownBody(
            data: message.text,
            selectable: true,
            styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
              p: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
              listBullet: theme.textTheme.bodyMedium,
              strong: TextStyle(
                fontWeight: FontWeight.w700,
                color: scheme.primary,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (onShare != null)
                IconButton(
                  icon: const Icon(Icons.ios_share_rounded, size: 18),
                  tooltip: 'Share this tip',
                  visualDensity: VisualDensity.compact,
                  color: scheme.onSurfaceVariant,
                  onPressed: onShare,
                ),
              // In-app reporting of AI output (Play AI-generated content policy)
              IconButton(
                icon: const Icon(Icons.outlined_flag_rounded, size: 18),
                tooltip: 'Report this response',
                visualDensity: VisualDensity.compact,
                color: scheme.onSurfaceVariant,
                onPressed: () => showReportAiSheet(
                  context,
                  kind: 'chat',
                  content: message.text,
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.82,
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: shape,
            gradient: isUser ? aqua.primaryGradient : null,
            color: isUser
                ? null
                : message.isError
                ? aqua.danger.withValues(alpha: 0.1)
                : aqua.glassFill,
            border: isUser
                ? null
                : Border.all(
                    color: message.isError
                        ? aqua.danger.withValues(alpha: 0.4)
                        : aqua.glassBorder,
                  ),
            boxShadow: isUser
                ? [
                    BoxShadow(
                      color: aqua.glow,
                      blurRadius: 16,
                      spreadRadius: -6,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: content,
        ),
      ),
    );
  }
}

/// Three pulsing dots while the assistant is thinking
class _TypingBubble extends StatefulWidget {
  const _TypingBubble();

  @override
  State<_TypingBubble> createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<_TypingBubble>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aqua = AquaTheme.of(context);
    final color = Theme.of(context).colorScheme.primary;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: aqua.glassFill,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: aqua.glassBorder),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < 3; i++) ...[
                if (i > 0) const SizedBox(width: 6),
                Opacity(
                  // Each dot peaks a third of a cycle after the previous one
                  opacity:
                      0.3 +
                      0.7 * (1 - ((_controller.value * 3 - i) % 3).clamp(0, 1)),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: color, blurRadius: 6)],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar({
    required this.controller,
    required this.enabled,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool enabled;
  final void Function([String? text]) onSend;

  @override
  Widget build(BuildContext context) {
    final aqua = AquaTheme.of(context);
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 4, 6, 4),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? scheme.surfaceContainerHigh
                    : scheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: aqua.glassBorder),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      enabled: enabled,
                      minLines: 1,
                      maxLines: 4,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => onSend(),
                      decoration: const InputDecoration(
                        hintText: 'Ask about your aquarium…',
                        filled: false,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Opacity(
                    opacity: enabled ? 1 : 0.4,
                    child: Material(
                      type: MaterialType.transparency,
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: aqua.primaryGradient,
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: enabled ? () => onSend() : null,
                          child: const Padding(
                            padding: EdgeInsets.all(11),
                            child: Icon(
                              Icons.arrow_upward_rounded,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'AI can make mistakes. Check important advice.',
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
