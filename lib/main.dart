import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '_application/application.dart';
import '_application/main/main.dart';
import 'bottom_navbar/bottom_navbar.dart';
import 'ui/ui.dart';

void main() {
  runApp(const MiniPOS());
}

class MiniPOS extends StatelessWidget {
  const MiniPOS({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await Permission.manageExternalStorage.request();
      await Permission.storage.request();
    });

    return MultiProvider(
      providers: mainProviders,
      child: MaterialApp(
        scaffoldMessengerKey: AppConstants.I.rootNavigatorKey,
        theme: myTheme,
        onGenerateRoute: appRoutes,
        home: const BottomNavbarBootstrap(),
      ),
    );
  }
}
