import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/aqua_theme.dart';
import '../../../../core/widgets/aqua_widgets.dart';
import '../../data/ai_service.dart';
import '../controllers/ai_providers.dart';

/// Why a user is flagging AI output; ids match the reportAiContent function
enum AiReportReason {
  harmful('harmful', 'Harmful or dangerous advice', Icons.dangerous_outlined),
  offensive('offensive', 'Offensive or inappropriate', Icons.report_outlined),
  inaccurate('inaccurate', 'Wrong or misleading', Icons.rule_rounded),
  other('other', 'Something else', Icons.more_horiz_rounded);

  const AiReportReason(this.id, this.label, this.icon);

  final String id;
  final String label;
  final IconData icon;
}

/// Bottom sheet for reporting an AI answer or health report from inside the
/// app, as Google Play's AI-generated content policy requires.
///
/// [kind] is "chat" or "health"; [content] is the text being reported.
Future<void> showReportAiSheet(
  BuildContext context, {
  required String kind,
  required String content,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _ReportAiSheet(kind: kind, content: content),
  );
}

class _ReportAiSheet extends ConsumerStatefulWidget {
  const _ReportAiSheet({required this.kind, required this.content});

  final String kind;
  final String content;

  @override
  ConsumerState<_ReportAiSheet> createState() => _ReportAiSheetState();
}

class _ReportAiSheetState extends ConsumerState<_ReportAiSheet> {
  AiReportReason? _reason;
  final _note = TextEditingController();
  bool _sending = false;
  String? _error;

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final reason = _reason;
    if (reason == null) return;
    setState(() {
      _sending = true;
      _error = null;
    });
    try {
      await ref
          .read(aiServiceProvider)
          .report(
            kind: widget.kind,
            reason: reason.id,
            content: widget.content,
            note: _note.text,
          );
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      Navigator.pop(context);
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Thanks. Your report was sent for review.'),
        ),
      );
    } on AiException catch (e) {
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final aqua = AquaTheme.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        0,
        20,
        20 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Report this AI response', style: textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(
            'Reports help us find answers that are harmful, offensive or '
            'wrong. The reported text is sent to the TankMind team for review.',
            style: textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          for (final reason in AiReportReason.values)
            RadioListTile<AiReportReason>(
              value: reason,
              // ignore: deprecated_member_use
              groupValue: _reason,
              // ignore: deprecated_member_use
              onChanged: _sending ? null : (v) => setState(() => _reason = v),
              secondary: Icon(reason.icon),
              title: Text(reason.label),
              contentPadding: EdgeInsets.zero,
            ),
          const SizedBox(height: 8),
          TextField(
            controller: _note,
            enabled: !_sending,
            maxLength: 500,
            maxLines: 3,
            minLines: 1,
            decoration: const InputDecoration(
              labelText: 'Add details (optional)',
            ),
          ),
          if (_error != null) ...[
            Text(
              _error!,
              style: textTheme.bodySmall?.copyWith(color: aqua.danger),
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 8),
          GradientButton(
            label: _sending ? 'Sending…' : 'Send report',
            icon: _sending ? null : Icons.flag_rounded,
            expand: true,
            onPressed: _reason == null || _sending ? null : _submit,
          ),
        ],
      ),
    );
  }
}
