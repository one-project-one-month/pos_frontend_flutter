import 'package:flutter/material.dart';
import 'package:mini_pos/home/view/home_screen.dart';

import '_application/application.dart';
import 'ui/ui.dart';

void main() {
  runApp(const MiniPOS());
}

class MiniPOS extends StatelessWidget {
  const MiniPOS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: AppConstants.I.rootNavigatorKey,
      theme: myTheme,
      home: const HomeScren(),
    );
  }
}
