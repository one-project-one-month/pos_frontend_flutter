import "package:flutter/material.dart";

extension ColorExtension on BuildContext {
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
