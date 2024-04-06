import "package:flutter/material.dart";

extension PaddingExtension on int {
  /// Padding all
  Padding get paddingAll => Padding(padding: EdgeInsets.all(toDouble()));

  /// Padding horizontally
  Padding get paddingHorizontal =>
      Padding(padding: EdgeInsets.symmetric(horizontal: toDouble()));

  /// Padding vertically
  Padding get paddingVertical =>
      Padding(padding: EdgeInsets.symmetric(vertical: toDouble()));
}

extension PaddingWidgetExtension on Widget {
  /// Padding all with widget
  Widget paddingAll(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  /// Padding horizontal with widget
  Widget paddingHorizontal(double padding) => Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: this,
      );

  /// Padding vertical with widget
  Widget paddingVertical(double padding) => Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: this,
      );
}
