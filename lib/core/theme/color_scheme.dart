import 'package:flutter/material.dart';

/// Application color scheme

class AppColorScheme {
  AppColorScheme._();

  static const Color primaryColor = Color(0xFF0077B6);
  static const Color secondaryColor = Color(0xFF00B4D8);
  static const Color tertiaryColor = Color(0xFF90E0EF);

  static ColorScheme get lightColorScheme {
    return ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    );
  }

  static ColorScheme get darkColorScheme {
    return ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    );
  }
}

