import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/aqua_theme.dart';
import '../../../../core/widgets/aqua_widgets.dart';
import '../../../../router/app_router.dart';
import '../../domain/tank_analysis.dart';
import '../controllers/ai_providers.dart';
import 'score_ring.dart';

/// AI health summary for a tank: score, status and the top actions, or a
/// prompt to run the first check
class TankHealthCard extends ConsumerWidget {
  const TankHealthCard({
    super.key,
    required this.tankId,
    required this.tankName,
  });

  final int tankId;
  final String tankName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tankAnalysisProvider(tankId)).value;
    final analysis = state?.analysis;
    final refreshing = state?.isRefreshing ?? false;

    void runCheck() =>
        ref.read(tankAnalysisProvider(tankId).notifier).refresh();
    void openReport() => Navigator.pushNamed(
      context,
      AppRouter.tankHealth,
      arguments: {'tankId': tankId, 'tankName': tankName},
    );

    final aqua = AquaTheme.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GlassCard(
      padding: const EdgeInsets.all(18),
      glowColor: analysis == null
          ? scheme.tertiary
          : aqua.statusColor(analysis.status.aquaStatus, scheme),
      onTap: analysis == null ? null : openReport,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GradientIconTile(
                icon: Icons.auto_awesome_rounded,
                size: 32,
                gradient: aqua.accentGradient,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text('AI Health Check', style: textTheme.titleMedium),
              ),
              if (analysis != null)
                refreshing
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : IconButton(
                        icon: const Icon(Icons.refresh_rounded),
                        tooltip: 'Run again',
                        visualDensity: VisualDensity.compact,
                        onPressed: runCheck,
                      ),
            ],
          ),
          const SizedBox(height: 14),
          if (analysis == null)
            _EmptyState(refreshing: refreshing, onRun: runCheck)
          else
            _Summary(analysis: analysis, onOpen: openReport),
          if (state?.error != null) ...[
            const SizedBox(height: 12),
            Text(
              state!.error!.message,
              style: textTheme.bodySmall?.copyWith(color: aqua.danger),
            ),
          ],
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.refreshing, required this.onRun});

  final bool refreshing;
  final VoidCallback onRun;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get a health score and a step-by-step action plan based on this '
          "tank's readings, livestock, plants and maintenance history.",
          style: textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        GradientButton(
          label: refreshing ? 'Analyzing…' : 'Run health check',
          icon: refreshing ? null : Icons.auto_awesome_rounded,
          gradient: AquaTheme.of(context).accentGradient,
          expand: true,
          onPressed: refreshing ? null : onRun,
        ),
      ],
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.analysis, required this.onOpen});

  final TankAnalysis analysis;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final aqua = AquaTheme.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final color = aqua.statusColor(analysis.status.aquaStatus, scheme);
    final topActions = analysis.actions.take(2).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ScoreRing(score: analysis.score, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatusPill(
                    label: analysis.status.label,
                    status: analysis.status.aquaStatus,
                  ),
                  const SizedBox(height: 8),
                  Text(analysis.headline, style: textTheme.titleSmall),
                  const SizedBox(height: 4),
                  Text(
                    'Checked ${timeAgo(analysis.createdAt)}',
                    style: textTheme.labelSmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (topActions.isNotEmpty) ...[
          const SizedBox(height: 16),
          for (final action in topActions)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(
                    action.priority == ActionPriority.now
                        ? Icons.priority_high_rounded
                        : Icons.check_circle_outline_rounded,
                    size: 18,
                    color: action.priority == ActionPriority.now
                        ? aqua.danger
                        : scheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      action.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
        ],
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              'View full plan',
              style: textTheme.labelLarge?.copyWith(color: scheme.primary),
            ),
            const SizedBox(width: 4),
            Icon(Icons.arrow_forward_rounded, size: 18, color: scheme.primary),
          ],
        ),
      ],
    );
  }
}

/// Short relative time like "just now", "5 min ago", "3 days ago"
String timeAgo(DateTime time) {
  final diff = DateTime.now().difference(time);
  if (diff.inMinutes < 1) return 'just now';
  if (diff.inHours < 1) return '${diff.inMinutes} min ago';
  if (diff.inDays < 1) return '${diff.inHours} h ago';
  if (diff.inDays == 1) return 'yesterday';
  return '${diff.inDays} days ago';
}
