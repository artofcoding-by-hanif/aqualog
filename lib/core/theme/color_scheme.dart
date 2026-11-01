import 'package:flutter/material.dart';

/// Deep-ocean palette.
///
/// Dark mode is the hero look: near-black navy depths, teal-to-cyan light
/// rays and glowing readings. Light mode ("aqua mist") keeps the same accents
/// on bright, airy surfaces.
class AquaPalette {
  AquaPalette._();

  // Depths (dark backgrounds, darkest first)
  static const Color abyss = Color(0xFF040A16);
  static const Color trench = Color(0xFF07122A);
  static const Color deep = Color(0xFF0B1B36);
  static const Color reef = Color(0xFF112646);
  static const Color shoal = Color(0xFF1A3459);

  // Accents
  static const Color teal = Color(0xFF14E0C0);
  static const Color cyan = Color(0xFF22D3EE);
  static const Color azure = Color(0xFF3B82F6);
  static const Color violet = Color(0xFF8B5CF6);

  // Status
  static const Color healthy = Color(0xFF34D399);
  static const Color caution = Color(0xFFFBBF24);
  static const Color danger = Color(0xFFFF5C7A);

  // Text on dark
  static const Color foam = Color(0xFFE8F4FF);
  static const Color mist = Color(0xFF8FA8C8);

  // Light-mode surfaces
  static const Color shallows = Color(0xFFF1F7FC);
  static const Color pearl = Color(0xFFFFFFFF);
  static const Color seaGlass = Color(0xFFE2EEF7);
  static const Color ink = Color(0xFF0B1B36);
  static const Color slate = Color(0xFF52688A);

  // Light-mode accents (darker so they read on white)
  static const Color tealDeep = Color(0xFF0BA88F);
  static const Color cyanDeep = Color(0xFF0891B2);
}

/// Application color schemes built from [AquaPalette]
class AppColorScheme {
  AppColorScheme._();

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AquaPalette.cyan,
    onPrimary: AquaPalette.abyss,
    primaryContainer: Color(0xFF0E3A52),
    onPrimaryContainer: Color(0xFFB9F2FF),
    secondary: AquaPalette.teal,
    onSecondary: AquaPalette.abyss,
    secondaryContainer: Color(0xFF0D3C3A),
    onSecondaryContainer: Color(0xFFAFFCEB),
    tertiary: AquaPalette.violet,
    onTertiary: AquaPalette.foam,
    tertiaryContainer: Color(0xFF2E2358),
    onTertiaryContainer: Color(0xFFE2D8FF),
    error: AquaPalette.danger,
    onError: AquaPalette.abyss,
    errorContainer: Color(0xFF4A1426),
    onErrorContainer: Color(0xFFFFD6DE),
    surface: AquaPalette.trench,
    onSurface: AquaPalette.foam,
    onSurfaceVariant: AquaPalette.mist,
    surfaceDim: AquaPalette.abyss,
    surfaceBright: AquaPalette.shoal,
    surfaceContainerLowest: AquaPalette.abyss,
    surfaceContainerLow: Color(0xFF091731),
    surfaceContainer: AquaPalette.deep,
    surfaceContainerHigh: AquaPalette.reef,
    surfaceContainerHighest: AquaPalette.shoal,
    outline: Color(0xFF5A7396),
    outlineVariant: Color(0xFF1F3A60),
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: AquaPalette.foam,
    onInverseSurface: AquaPalette.deep,
    inversePrimary: AquaPalette.cyanDeep,
  );

  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AquaPalette.cyanDeep,
    onPrimary: AquaPalette.pearl,
    primaryContainer: Color(0xFFCDF3FB),
    onPrimaryContainer: Color(0xFF053344),
    secondary: AquaPalette.tealDeep,
    onSecondary: AquaPalette.pearl,
    secondaryContainer: Color(0xFFC9F7EC),
    onSecondaryContainer: Color(0xFF053B32),
    tertiary: Color(0xFF6D4AE0),
    onTertiary: AquaPalette.pearl,
    tertiaryContainer: Color(0xFFE6DEFF),
    onTertiaryContainer: Color(0xFF24145E),
    error: Color(0xFFE11D48),
    onError: AquaPalette.pearl,
    errorContainer: Color(0xFFFFE1E7),
    onErrorContainer: Color(0xFF5F0A1E),
    surface: AquaPalette.shallows,
    onSurface: AquaPalette.ink,
    onSurfaceVariant: AquaPalette.slate,
    surfaceDim: Color(0xFFDCE7F1),
    surfaceBright: AquaPalette.pearl,
    surfaceContainerLowest: AquaPalette.pearl,
    surfaceContainerLow: Color(0xFFF7FBFE),
    surfaceContainer: Color(0xFFEDF4FA),
    surfaceContainerHigh: AquaPalette.seaGlass,
    surfaceContainerHighest: Color(0xFFD6E5F1),
    outline: Color(0xFF8AA0BC),
    outlineVariant: Color(0xFFD3E1EE),
    shadow: Color(0xFF0B1B36),
    scrim: Colors.black,
    inverseSurface: AquaPalette.deep,
    onInverseSurface: AquaPalette.foam,
    inversePrimary: AquaPalette.cyan,
  );
}
