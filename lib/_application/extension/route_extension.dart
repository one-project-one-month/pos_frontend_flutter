import "package:flutter/material.dart";

extension RouteExtension on BuildContext {
  Future<void> toNamed({
    required String fullPath,
    bool redirect = false,
  }) async {
    if (redirect) {
      Navigator.of(this).pushNamedAndRemoveUntil(
        fullPath,
        (route) {
          return true;
        },
      );
    } else {
      Navigator.of(this).pushNamed(fullPath);
    }
  }

  void pop() {
    Navigator.of(this).pop();
  }
}
