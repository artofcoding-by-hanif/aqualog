import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../ai/domain/tank_analysis.dart';
import '../../livestock/fish/presentation/controllers/fish_provider.dart';
import '../../livestock/invertebrates/presentation/controllers/invertebrate_provider.dart';
import '../../plants/presentation/controllers/plant_provider.dart';
import '../../tank/domain/entities/tank.dart';
import '../../tank/presentation/controllers/tank_image_provider.dart';
import '../domain/milestones.dart';
import '../domain/share_content.dart';
import 'controllers/milestone_providers.dart';
import 'share_cards.dart';
import 'share_preview_screen.dart';

/// Entry points for every share button in the app

Future<void> shareTank(
  BuildContext context,
  WidgetRef ref,
  TankEntity tank,
) async {
  final id = tank.id!;
  final results = await Future.wait([
    ref.read(tankCoverImageProvider(id).future),
    ref.read(aliveFishCountProvider(id).future),
    ref.read(activePlantCountProvider(id).future),
    ref.read(aliveInvertebrateCountProvider(id).future),
  ]);
  if (!context.mounted) return;

  final coverPath = (results[0] as dynamic)?.imagePath as String?;
  final data = TankShowcase(
    tank: tank,
    coverPath: coverPath,
    fish: results[1] as int,
    plants: results[2] as int,
    invertebrates: results[3] as int,
  );
  final days = tank.daysSinceSetup;
  await showSharePreview(
    context,
    kind: ShareKind.tank,
    card: TankShowcaseCard(data: data),
    precache: [?coverPath],
    caption: [
      'Meet my ${tank.name} 🐠',
      '${tank.volumeLiters.toStringAsFixed(0)} L ${tank.tankType.displayName.toLowerCase()} aquarium'
          '${days != null ? ', $days days running' : ''}.',
      'I track water, livestock and maintenance with TankMind.',
    ].join(' '),
  );
}

Future<void> shareHealth(
  BuildContext context, {
  required String tankName,
  required TankAnalysis analysis,
}) {
  return showSharePreview(
    context,
    kind: ShareKind.health,
    card: HealthScoreCard(tankName: tankName, analysis: analysis),
    caption:
        'My $tankName scored ${analysis.score}/100 on the TankMind AI health '
        'check 🌿 What would yours score?',
  );
}

Future<void> shareAiTip(
  BuildContext context, {
  required String answer,
  String? question,
  String? tankName,
}) {
  return showSharePreview(
    context,
    kind: ShareKind.tip,
    card: AiTipCard(answer: answer, question: question, tankName: tankName),
    caption:
        'Handy aquarium tip from TankMind AI 💡 '
                '${question != null ? '“${excerpt(question, 80)}”' : ''}'
            .trim(),
  );
}

Future<void> shareMilestone(
  BuildContext context,
  WidgetRef ref,
  Milestone milestone,
) async {
  final shared = await showSharePreview(
    context,
    kind: ShareKind.milestone,
    card: MilestoneCard(milestone: milestone),
    precache: [?milestone.coverPath],
    caption: '${milestone.headline} ${milestone.emoji} Logged with TankMind.',
  );
  if (shared) {
    await ref.read(seenMilestonesProvider.notifier).markSeen(milestone);
  }
}
