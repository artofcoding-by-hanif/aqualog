import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/aqua_theme.dart';
import '../../../../core/widgets/aqua_widgets.dart';
import '../../domain/entities/tank.dart';
import '../controllers/tank_image_provider.dart';

/// Tank card widget for displaying tank summary
class TankCard extends ConsumerWidget {
  const TankCard({
    super.key,
    required this.tank,
    this.onTap,
    this.isSelected = false,
  });

  final TankEntity tank;
  final VoidCallback? onTap;
  final bool isSelected;

  static const double _bannerHeight = 132;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final coverImage = tank.id != null
        ? ref.watch(tankCoverImageProvider(tank.id!)).value
        : null;

    return GlassCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.zero,
      glowColor: isSelected ? colorScheme.primary : null,
      borderColor: isSelected
          ? colorScheme.primary.withValues(alpha: 0.6)
          : null,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: _bannerHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                _buildBanner(context, coverImage?.imagePath),
                // Fade into the card body
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0),
                        Colors.black.withValues(alpha: 0.45),
                      ],
                    ),
                  ),
                ),
                if (tank.isActive)
                  const Positioned(top: 12, right: 12, child: _ActiveBadge()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 12, 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tank.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _StatChip(
                            icon: Icons.water_drop_rounded,
                            label: tank.volumeDisplay(),
                          ),
                          _StatChip(
                            emoji: tank.tankType.icon,
                            label: tank.tankType.displayName,
                          ),
                          if (tank.daysSinceSetup != null)
                            _StatChip(
                              icon: Icons.schedule_rounded,
                              label: '${tank.daysSinceSetup} days',
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner(BuildContext context, String? imagePath) {
    final fallback = DecoratedBox(
      decoration: BoxDecoration(gradient: AquaTheme.of(context).accentGradient),
      child: Center(
        child: Text(tank.tankType.icon, style: const TextStyle(fontSize: 48)),
      ),
    );
    if (imagePath == null) return fallback;

    return Image.file(
      File(imagePath),
      fit: BoxFit.cover,
      cacheWidth: 900,
      errorBuilder: (context, error, stackTrace) => fallback,
    );
  }
}

class _ActiveBadge extends StatelessWidget {
  const _ActiveBadge();

  @override
  Widget build(BuildContext context) {
    final aqua = AquaTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: aqua.healthy.withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: aqua.healthy,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: aqua.healthy, blurRadius: 8)],
            ),
          ),
          const SizedBox(width: 6),
          Text(
            'Active',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, this.icon, this.emoji});

  final String label;
  final IconData? icon;
  final String? emoji;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (emoji != null)
            Text(emoji!, style: const TextStyle(fontSize: 12))
          else
            Icon(icon, size: 14, color: scheme.primary),
          const SizedBox(width: 5),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: scheme.onSurface),
          ),
        ],
      ),
    );
  }
}
