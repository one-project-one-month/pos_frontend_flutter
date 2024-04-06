import "package:flutter/material.dart";

extension SizeExtension on BuildContext {
  double get dw => MediaQuery.of(this).size.width;
  double get dh => MediaQuery.of(this).size.height;
}
