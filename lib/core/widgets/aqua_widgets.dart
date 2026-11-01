import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../theme/aqua_theme.dart';

/// Full-screen ocean backdrop: depth gradient plus two soft light pools.
///
/// Put it behind a transparent [Scaffold] via [AquaScaffold], or use it
/// directly as the bottom layer of a [Stack].
class AquaBackground extends StatelessWidget {
  const AquaBackground({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final aqua = AquaTheme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(gradient: aqua.background),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -140,
            right: -120,
            child: _LightPool(color: aqua.ambientA, size: 360),
          ),
          Positioned(
            top: 260,
            left: -160,
            child: _LightPool(color: aqua.ambientB, size: 320),
          ),
          ?child,
        ],
      ),
    );
  }
}

class _LightPool extends StatelessWidget {
  const _LightPool({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
        ),
      ),
    );
  }
}

/// A [Scaffold] drawn over [AquaBackground].
///
/// Each route paints its own backdrop, so pages never show through each
/// other during transitions.
class AquaScaffold extends StatelessWidget {
  const AquaScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.extendBodyBehindAppBar = false,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) {
    return AquaBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}

/// Frosted-glass surface: translucent fill, hairline border, top sheen and
/// an optional colored glow.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.onTap,
    this.glowColor,
    this.borderColor,
    this.radius = AppTheme.radius,
    this.gradient,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onTap;

  /// Adds a soft outer glow in this color (e.g. a status color)
  final Color? glowColor;
  final Color? borderColor;
  final double radius;

  /// Replaces the glass fill, e.g. for a tinted hero card
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final aqua = AquaTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderRadius = BorderRadius.circular(radius);

    return Padding(
      padding: margin,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: [
            if (glowColor != null)
              BoxShadow(
                color: glowColor!.withValues(alpha: isDark ? 0.28 : 0.18),
                blurRadius: 24,
                spreadRadius: -6,
              ),
            if (!isDark)
              BoxShadow(
                color: const Color(0xFF0B1B36).withValues(alpha: 0.06),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
          ],
        ),
        child: Material(
          type: MaterialType.transparency,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: gradient == null ? aqua.glassFill : null,
              gradient: gradient,
              border: Border.all(color: borderColor ?? aqua.glassBorder),
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: borderRadius,
              // Clip so photos and banners follow the rounded corners
              child: ClipRRect(
                borderRadius: borderRadius,
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Padding(padding: padding, child: child),
                    // Sheen along the top edge, like light hitting glass
                    Positioned(
                      top: 0,
                      left: radius,
                      right: radius,
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              aqua.glassHighlight.withValues(alpha: 0),
                              aqua.glassHighlight,
                              aqua.glassHighlight.withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Rounded square holding an icon or emoji on a gradient, with a soft glow
class GradientIconTile extends StatelessWidget {
  const GradientIconTile({
    super.key,
    this.icon,
    this.emoji,
    this.size = 48,
    this.gradient,
    this.color,
  }) : assert(icon != null || emoji != null);

  final IconData? icon;
  final String? emoji;
  final double size;

  /// Defaults to the theme's primary gradient
  final Gradient? gradient;

  /// Tints the tile with a single color instead of a gradient
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final aqua = AquaTheme.of(context);
    final fill = color != null
        ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color!.withValues(alpha: 0.35),
              color!.withValues(alpha: 0.12),
            ],
          )
        : (gradient ?? aqua.primaryGradient);
    final glow = color ?? aqua.glow;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: fill,
        borderRadius: BorderRadius.circular(size * 0.32),
        border: color != null
            ? Border.all(color: color!.withValues(alpha: 0.4))
            : null,
        boxShadow: [
          BoxShadow(
            color: glow.withValues(alpha: 0.35),
            blurRadius: size * 0.4,
            spreadRadius: -size * 0.12,
            offset: Offset(0, size * 0.1),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: emoji != null
          ? Text(emoji!, style: TextStyle(fontSize: size * 0.48))
          : Icon(icon, size: size * 0.5, color: color ?? Colors.white),
    );
  }
}

/// Small pill with a glowing dot, for statuses like "Overdue" or "Optimal"
class StatusPill extends StatelessWidget {
  const StatusPill({
    super.key,
    required this.label,
    this.status = AquaStatus.neutral,
    this.color,
  });

  final String label;
  final AquaStatus status;

  /// Overrides the status color
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tint = color ?? AquaTheme.of(context).statusColor(status, scheme);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: tint.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: tint,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: tint.withValues(alpha: 0.8), blurRadius: 6),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: tint,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Primary call-to-action filled with the theme gradient and a glow
class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.gradient,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Gradient? gradient;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final aqua = AquaTheme.of(context);
    final enabled = onPressed != null;
    final radius = BorderRadius.circular(AppTheme.radiusSmall);

    final content = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(color: Colors.white),
        ),
      ],
    );

    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: [
            if (enabled)
              BoxShadow(
                color: aqua.glow,
                blurRadius: 20,
                spreadRadius: -6,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: Material(
          type: MaterialType.transparency,
          child: Ink(
            decoration: BoxDecoration(
              gradient: gradient ?? aqua.primaryGradient,
              borderRadius: radius,
            ),
            child: InkWell(
              onTap: onPressed,
              borderRadius: radius,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 52),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Center(widthFactor: 1, child: content),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Text with the primary gradient painted through it
class GradientText extends StatelessWidget {
  const GradientText(this.text, {super.key, this.style, this.gradient});

  final String text;
  final TextStyle? style;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final fill = gradient ?? AquaTheme.of(context).primaryGradient;
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => fill.createShader(bounds),
      child: Text(text, style: style),
    );
  }
}
