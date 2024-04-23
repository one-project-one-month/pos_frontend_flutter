import 'package:flutter/material.dart';

Future<void> showAlertBox(BuildContext context, {required Widget child}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return child;
    },
  );
}
