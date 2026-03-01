import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final coverImageAsync = tank.id != null
        ? ref.watch(tankCoverImageProvider(tank.id!))
        : const AsyncValue<void>.data(null);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected
            ? BorderSide(color: colorScheme.primary, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildTankImage(context, colorScheme, coverImageAsync),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            tank.name,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (tank.isActive)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Active',
                              style: TextStyle(
                                fontSize: 10,
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${tank.volumeDisplay()} • ${tank.tankType.displayName}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                    if (tank.daysSinceSetup != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        '${tank.daysSinceSetup} days old',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.outline,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTankImage(
    BuildContext context,
    ColorScheme colorScheme,
    AsyncValue<dynamic> coverImageAsync,
  ) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: coverImageAsync.when(
        data: (coverImage) {
          if (coverImage != null && coverImage.imagePath != null) {
            final file = File(coverImage.imagePath);
            return Image.file(
              file,
              fit: BoxFit.cover,
              width: 56,
              height: 56,
              errorBuilder: (context, error, stackTrace) =>
                  _buildIconFallback(),
            );
          }
          return _buildIconFallback();
        },
        loading: () => _buildIconFallback(),
        error: (e, s) => _buildIconFallback(),
      ),
    );
  }

  Widget _buildIconFallback() {
    return Center(
      child: Text(tank.tankType.icon, style: const TextStyle(fontSize: 28)),
    );
  }
}
