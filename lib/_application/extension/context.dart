import "package:flutter/material.dart";

extension ColorExtension on BuildContext {
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  Color get success => const Color(0xFF56CA00);
  Color get warning => const Color(0xFFFFB400);
  Color get danger => const Color(0xFFFF4C51);
  Color get bgColor => Theme.of(this).scaffoldBackgroundColor;

  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
