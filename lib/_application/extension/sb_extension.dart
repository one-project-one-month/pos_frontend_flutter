import "package:flutter/material.dart";

extension SizeBoxExtension on int {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
  SizedBox get wh => SizedBox(
        width: toDouble(),
        height: toDouble(),
      );
}
