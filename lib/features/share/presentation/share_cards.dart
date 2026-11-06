import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/theme/aqua_theme.dart';
import '../../../core/theme/color_scheme.dart';
import '../../../core/widgets/aqua_widgets.dart';
import '../../ai/domain/tank_analysis.dart';
import '../../ai/presentation/widgets/score_ring.dart';
import '../../tank/domain/entities/tank.dart';
import '../domain/milestones.dart';
import '../domain/share_content.dart';

/// Logical size of every share card; captured at 3x for 1080 x 1350 (4:5,
/// the portrait size Instagram, Facebook and WhatsApp all display well)
const Size kShareCardSize = Size(360, 450);

/// Branded frame shared by all cards: ocean backdrop, TankMind header and a
/// "get the app" footer
class ShareCardFrame extends StatelessWidget {
  const ShareCardFrame({super.key, required this.child, this.background});

  final Widget child;

  /// Replaces the ocean gradient (e.g. a tank photo)
  final Widget? background;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final aqua = AquaTheme.of(context);

    return SizedBox.fromSize(
      size: kShareCardSize,
      child: ClipRect(
        child: Stack(
          fit: StackFit.expand,
          children: [
            background ?? const AquaBackground(),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(2),
                          child: Image.asset(
                            'app_icon.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GradientText(
                        'TankMind',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: child),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: aqua.glassBorder),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.shop_rounded,
                          size: 14,
                          color: AquaPalette.teal,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            ShareLinks.display,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.labelSmall?.copyWith(
                              color: AquaPalette.foam,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tank photo filling the card, darkened for legible text
class _PhotoBackground extends StatelessWidget {
  const _PhotoBackground({required this.path, required this.fallbackEmoji});

  final String? path;
  final String fallbackEmoji;

  @override
  Widget build(BuildContext context) {
    final hasPhoto = path != null && File(path!).existsSync();
    return Stack(
      fit: StackFit.expand,
      children: [
        if (hasPhoto)
          Image.file(File(path!), fit: BoxFit.cover)
        else
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: AquaTheme.of(context).accentGradient,
            ),
            child: Center(
              child: Text(fallbackEmoji, style: const TextStyle(fontSize: 120)),
            ),
          ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xB3020814),
                Color(0x26020814),
                Color(0x40020814),
                Color(0xF2020814),
              ],
              stops: [0, 0.22, 0.5, 1],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip(this.value, this.label);

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
            Text(
              label,
              style: textTheme.labelSmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.75),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Data for the tank showcase card
class TankShowcase {
  const TankShowcase({
    required this.tank,
    this.coverPath,
    this.fish = 0,
    this.plants = 0,
    this.invertebrates = 0,
  });

  final TankEntity tank;
  final String? coverPath;
  final int fish;
  final int plants;
  final int invertebrates;
}

/// "Look at my tank": cover photo with key stats
class TankShowcaseCard extends StatelessWidget {
  const TankShowcaseCard({super.key, required this.data});

  final TankShowcase data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final tank = data.tank;
    final days = tank.daysSinceSetup;

    return ShareCardFrame(
      background: _PhotoBackground(
        path: data.coverPath,
        fallbackEmoji: tank.tankType.icon,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tank.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            [
              '${tank.volumeLiters.toStringAsFixed(tank.volumeLiters < 100 ? 1 : 0)} L',
              tank.tankType.displayName,
              if (tank.isCycled) 'Cycled ✓',
            ].join(' · '),
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              for (final (i, chip) in [
                if (days != null)
                  _StatChip(
                    days >= 365
                        ? '${(days / 365).toStringAsFixed(1)}y'
                        : '$days',
                    days >= 365 ? 'running' : 'days',
                  ),
                // Zero counts make a less flattering post; leave them out
                if (data.fish > 0) _StatChip('${data.fish}', 'fish'),
                if (data.plants > 0) _StatChip('${data.plants}', 'plants'),
                if (data.invertebrates > 0)
                  _StatChip('${data.invertebrates}', 'inverts'),
              ].indexed) ...[if (i > 0) const SizedBox(width: 8), chip],
            ],
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}

/// "My tank scored 92": AI health score with headline
class HealthScoreCard extends StatelessWidget {
  const HealthScoreCard({
    super.key,
    required this.tankName,
    required this.analysis,
  });

  final String tankName;
  final TankAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final color = AquaTheme.of(
      context,
    ).statusColor(analysis.status.aquaStatus, scheme);

    return ShareCardFrame(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'AI HEALTH CHECK',
            style: textTheme.labelSmall?.copyWith(
              letterSpacing: 2,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            tankName,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.titleLarge,
          ),
          const SizedBox(height: 18),
          ScoreRing(
            score: analysis.score,
            color: color,
            size: 150,
            strokeWidth: 13,
            animate: false,
          ),
          const SizedBox(height: 14),
          StatusPill(
            label: analysis.status.label,
            status: analysis.status.aquaStatus,
          ),
          const SizedBox(height: 12),
          Text(
            excerpt(analysis.headline, 110),
            textAlign: TextAlign.center,
            maxLines: 3,
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

/// A useful AI answer, styled as a quote
class AiTipCard extends StatelessWidget {
  const AiTipCard({
    super.key,
    required this.answer,
    this.question,
    this.tankName,
  });

  final String answer;
  final String? question;
  final String? tankName;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final aqua = AquaTheme.of(context);

    return ShareCardFrame(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GradientIconTile(
                  icon: Icons.auto_awesome_rounded,
                  size: 30,
                  gradient: aqua.accentGradient,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Tip from TankMind AI',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelLarge?.copyWith(
                      color: scheme.tertiary,
                    ),
                  ),
                ),
              ],
            ),
            if (question != null) ...[
              const SizedBox(height: 12),
              Text(
                '“${excerpt(question!, 90)}”',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleMedium,
              ),
            ],
            const SizedBox(height: 10),
            Expanded(
              child: GlassCard(
                padding: const EdgeInsets.all(14),
                child: Text(
                  excerpt(plainTextFromMarkdown(answer), 430),
                  overflow: TextOverflow.fade,
                  style: textTheme.bodySmall?.copyWith(
                    height: 1.45,
                    color: AquaPalette.foam,
                  ),
                ),
              ),
            ),
            if (tankName != null) ...[
              const SizedBox(height: 8),
              Text(
                'Personalised for $tankName',
                style: textTheme.labelSmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Celebrates a milestone such as "100 days running"
class MilestoneCard extends StatelessWidget {
  const MilestoneCard({super.key, required this.milestone});

  final Milestone milestone;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ShareCardFrame(
      background: _PhotoBackground(
        path: milestone.coverPath,
        fallbackEmoji: milestone.emoji,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(milestone.emoji, style: const TextStyle(fontSize: 44)),
          const SizedBox(height: 4),
          GradientText(
            milestone.value,
            style: textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 96,
              height: 1,
            ),
          ),
          Text(
            milestone.unit.toUpperCase(),
            style: textTheme.labelLarge?.copyWith(
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            milestone.headline,
            textAlign: TextAlign.center,
            style: textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
