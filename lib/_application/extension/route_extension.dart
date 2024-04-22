import "package:flutter/material.dart";

extension RouteExtension on BuildContext {
  Future<void> toNamed({
    required String fullPath,
    bool redirect = true,
    Object? arguments,
  }) async {
    if (!redirect) {
      Navigator.of(this).pushNamedAndRemoveUntil(
        fullPath,
        (route) {
          return true;
        },
        arguments: arguments,
      );
    } else {
      Navigator.of(this).pushNamed(fullPath, arguments: arguments);
    }
  }

  void pop() {
    Navigator.of(this).pop();
  }
}
