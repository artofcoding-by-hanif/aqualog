import 'package:flutter/material.dart';

import 'color_scheme.dart';

/// Health of a reading or task, used for glow and badge colors
enum AquaStatus { healthy, caution, danger, neutral }

/// Design tokens that Material's [ColorScheme] has no slot for:
/// gradients, glass surfaces and status glows.
///
/// Read with `AquaTheme.of(context)`.
@immutable
class AquaTheme extends ThemeExtension<AquaTheme> {
  const AquaTheme({
    required this.background,
    required this.primaryGradient,
    required this.accentGradient,
    required this.glassFill,
    required this.glassBorder,
    required this.glassHighlight,
    required this.glow,
    required this.healthy,
    required this.caution,
    required this.danger,
    required this.ambientA,
    required this.ambientB,
  });

  /// Full-screen backdrop gradient
  final Gradient background;

  /// Teal to cyan, for primary actions and hero accents
  final Gradient primaryGradient;

  /// Cyan to violet, for AI and premium accents
  final Gradient accentGradient;

  /// Translucent card fill
  final Color glassFill;

  /// Hairline border on glass cards
  final Color glassBorder;

  /// Top-edge sheen on glass cards
  final Color glassHighlight;

  /// Soft glow behind highlighted elements
  final Color glow;

  final Color healthy;
  final Color caution;
  final Color danger;

  /// Colors of the two blurred light pools in [AquaBackground]
  final Color ambientA;
  final Color ambientB;

  static AquaTheme of(BuildContext context) =>
      Theme.of(context).extension<AquaTheme>() ?? dark;

  Color statusColor(AquaStatus status, ColorScheme scheme) {
    return switch (status) {
      AquaStatus.healthy => healthy,
      AquaStatus.caution => caution,
      AquaStatus.danger => danger,
      AquaStatus.neutral => scheme.primary,
    };
  }

  static const dark = AquaTheme(
    background: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AquaPalette.deep, AquaPalette.trench, AquaPalette.abyss],
      stops: [0, 0.45, 1],
    ),
    primaryGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AquaPalette.teal, AquaPalette.cyan, AquaPalette.azure],
      stops: [0, 0.55, 1],
    ),
    accentGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AquaPalette.cyan, AquaPalette.violet],
    ),
    glassFill: Color(0x1A8FB8FF),
    glassBorder: Color(0x2E9CC9FF),
    glassHighlight: Color(0x33FFFFFF),
    glow: Color(0x6622D3EE),
    healthy: AquaPalette.healthy,
    caution: AquaPalette.caution,
    danger: AquaPalette.danger,
    ambientA: Color(0x5514E0C0),
    ambientB: Color(0x443B82F6),
  );

  static const light = AquaTheme(
    background: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFE3F4FB), AquaPalette.shallows, Color(0xFFF7FAFD)],
      stops: [0, 0.4, 1],
    ),
    primaryGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AquaPalette.tealDeep, AquaPalette.cyanDeep, Color(0xFF2563EB)],
      stops: [0, 0.55, 1],
    ),
    accentGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AquaPalette.cyanDeep, Color(0xFF6D4AE0)],
    ),
    glassFill: Color(0xCCFFFFFF),
    glassBorder: Color(0x1A0B1B36),
    glassHighlight: Color(0xFFFFFFFF),
    glow: Color(0x330891B2),
    healthy: Color(0xFF059669),
    caution: Color(0xFFD97706),
    danger: Color(0xFFE11D48),
    ambientA: Color(0x3314E0C0),
    ambientB: Color(0x2622D3EE),
  );

  @override
  AquaTheme copyWith({
    Gradient? background,
    Gradient? primaryGradient,
    Gradient? accentGradient,
    Color? glassFill,
    Color? glassBorder,
    Color? glassHighlight,
    Color? glow,
    Color? healthy,
    Color? caution,
    Color? danger,
    Color? ambientA,
    Color? ambientB,
  }) {
    return AquaTheme(
      background: background ?? this.background,
      primaryGradient: primaryGradient ?? this.primaryGradient,
      accentGradient: accentGradient ?? this.accentGradient,
      glassFill: glassFill ?? this.glassFill,
      glassBorder: glassBorder ?? this.glassBorder,
      glassHighlight: glassHighlight ?? this.glassHighlight,
      glow: glow ?? this.glow,
      healthy: healthy ?? this.healthy,
      caution: caution ?? this.caution,
      danger: danger ?? this.danger,
      ambientA: ambientA ?? this.ambientA,
      ambientB: ambientB ?? this.ambientB,
    );
  }

  @override
  AquaTheme lerp(ThemeExtension<AquaTheme>? other, double t) {
    if (other is! AquaTheme) return this;
    return AquaTheme(
      background: Gradient.lerp(background, other.background, t)!,
      primaryGradient: Gradient.lerp(
        primaryGradient,
        other.primaryGradient,
        t,
      )!,
      accentGradient: Gradient.lerp(accentGradient, other.accentGradient, t)!,
      glassFill: Color.lerp(glassFill, other.glassFill, t)!,
      glassBorder: Color.lerp(glassBorder, other.glassBorder, t)!,
      glassHighlight: Color.lerp(glassHighlight, other.glassHighlight, t)!,
      glow: Color.lerp(glow, other.glow, t)!,
      healthy: Color.lerp(healthy, other.healthy, t)!,
      caution: Color.lerp(caution, other.caution, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      ambientA: Color.lerp(ambientA, other.ambientA, t)!,
      ambientB: Color.lerp(ambientB, other.ambientB, t)!,
    );
  }
}
