import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/_application/main/main_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MainController controller;
  @override
  void initState() {
    controller = MainController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await controller.checkStaffInfo(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(loading),
        ],
      ),
    );
  }
}
