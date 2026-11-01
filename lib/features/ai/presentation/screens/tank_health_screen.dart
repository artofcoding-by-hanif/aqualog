import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/aqua_theme.dart';
import '../../../../core/widgets/aqua_widgets.dart';
import '../../../../router/app_router.dart';
import '../../domain/tank_analysis.dart';
import '../controllers/ai_providers.dart';
import '../widgets/score_ring.dart';
import '../widgets/tank_health_card.dart' show timeAgo;

/// Full AI health report for a tank: score, summary, action plan, findings
class TankHealthScreen extends ConsumerStatefulWidget {
  const TankHealthScreen({
    super.key,
    required this.tankId,
    required this.tankName,
  });

  final int tankId;
  final String tankName;

  @override
  ConsumerState<TankHealthScreen> createState() => _TankHealthScreenState();
}

class _TankHealthScreenState extends ConsumerState<TankHealthScreen> {
  /// Actions ticked off on this visit
  final Set<int> _done = {};

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(tankAnalysisProvider(widget.tankId));
    final state = asyncState.value;
    final analysis = state?.analysis;
    final refreshing = state?.isRefreshing ?? false;
    final aqua = AquaTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Report'),
        actions: [
          if (refreshing)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              tooltip: 'Run again',
              onPressed: () {
                setState(_done.clear);
                ref
                    .read(tankAnalysisProvider(widget.tankId).notifier)
                    .refresh();
              },
            ),
        ],
      ),
      body: analysis == null
          ? Center(
              child: asyncState.isLoading || refreshing
                  ? const CircularProgressIndicator()
                  : Text(state?.error?.message ?? 'No report yet'),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              children: [
                _buildHero(context, analysis),
                if (state?.error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    state!.error!.message,
                    style: TextStyle(color: aqua.danger),
                  ),
                ],
                const SizedBox(height: 28),
                if (analysis.actions.isNotEmpty) ...[
                  Text(
                    'Action Plan',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  for (final (i, action) in analysis.actions.indexed)
                    _ActionTile(
                      action: action,
                      done: _done.contains(i),
                      onToggle: () => setState(
                        () =>
                            _done.contains(i) ? _done.remove(i) : _done.add(i),
                      ),
                    ),
                  const SizedBox(height: 24),
                ],
                if (analysis.findings.isNotEmpty) ...[
                  Text(
                    'What we found',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  for (final finding in analysis.findings)
                    _FindingTile(finding: finding),
                  const SizedBox(height: 24),
                ],
                GradientButton(
                  label: 'Ask the assistant',
                  icon: Icons.chat_bubble_outline_rounded,
                  gradient: aqua.accentGradient,
                  expand: true,
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRouter.aiChat,
                    arguments: {
                      'tankId': widget.tankId,
                      'tankName': widget.tankName,
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'AI suggestions can be wrong. Double-check anything that '
                  'affects your livestock.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildHero(BuildContext context, TankAnalysis analysis) {
    final aqua = AquaTheme.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final color = aqua.statusColor(analysis.status.aquaStatus, scheme);

    return GlassCard(
      padding: const EdgeInsets.all(22),
      glowColor: color,
      child: Column(
        children: [
          ScoreRing(
            score: analysis.score,
            color: color,
            size: 140,
            strokeWidth: 12,
          ),
          const SizedBox(height: 16),
          StatusPill(
            label: analysis.status.label,
            status: analysis.status.aquaStatus,
          ),
          const SizedBox(height: 12),
          Text(
            analysis.headline,
            textAlign: TextAlign.center,
            style: textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            analysis.summary,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${widget.tankName} · checked ${timeAgo(analysis.createdAt)}',
            style: textTheme.labelSmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.action,
    required this.done,
    required this.onToggle,
  });

  final AnalysisAction action;
  final bool done;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final aqua = AquaTheme.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final status = switch (action.priority) {
      ActionPriority.now => AquaStatus.danger,
      ActionPriority.soon => AquaStatus.caution,
      ActionPriority.routine => AquaStatus.neutral,
    };

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
      onTap: onToggle,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: done,
            onChanged: (_) => onToggle(),
            shape: const CircleBorder(),
            activeColor: aqua.healthy,
          ),
          Expanded(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: done ? 0.5 : 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    action.title,
                    style: textTheme.titleSmall?.copyWith(
                      decoration: done ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    action.detail,
                    style: textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  StatusPill(label: action.priority.label, status: status),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FindingTile extends StatelessWidget {
  const _FindingTile({required this.finding});

  final AnalysisFinding finding;

  @override
  Widget build(BuildContext context) {
    final aqua = AquaTheme.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final color = aqua.statusColor(finding.severity.aquaStatus, scheme);
    final icon = switch (finding.severity) {
      FindingSeverity.good => Icons.check_rounded,
      FindingSeverity.info => Icons.info_outline_rounded,
      FindingSeverity.warning => Icons.warning_amber_rounded,
      FindingSeverity.critical => Icons.error_outline_rounded,
    };

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GradientIconTile(icon: icon, color: color, size: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(finding.title, style: textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(
                  finding.detail,
                  style: textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
