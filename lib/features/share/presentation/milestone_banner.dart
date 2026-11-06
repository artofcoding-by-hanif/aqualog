import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/aqua_theme.dart';
import '../../../core/widgets/aqua_widgets.dart';
import 'controllers/milestone_providers.dart';
import 'share_actions.dart';

/// Dashboard card celebrating the next unshared milestone, with a Share
/// button. Hidden when there is nothing new to celebrate.
class MilestoneBanner extends ConsumerWidget {
  const MilestoneBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final milestone = ref.watch(nextMilestoneProvider).value;
    if (milestone == null) return const SizedBox.shrink();

    final aqua = AquaTheme.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: GlassCard(
        padding: const EdgeInsets.fromLTRB(16, 14, 6, 14),
        glowColor: aqua.healthy,
        borderColor: aqua.healthy.withValues(alpha: 0.4),
        onTap: () => shareMilestone(context, ref, milestone),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: aqua.healthy.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                milestone.emoji,
                style: const TextStyle(fontSize: 26),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    milestone.headline,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleSmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Share the moment with fellow fishkeepers',
                    style: textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.ios_share_rounded, color: aqua.healthy),
              tooltip: 'Share',
              onPressed: () => shareMilestone(context, ref, milestone),
            ),
            IconButton(
              icon: const Icon(Icons.close_rounded, size: 18),
              tooltip: 'Dismiss',
              color: scheme.onSurfaceVariant,
              onPressed: () =>
                  ref.read(seenMilestonesProvider.notifier).markSeen(milestone),
            ),
          ],
        ),
      ),
    );
  }
}
