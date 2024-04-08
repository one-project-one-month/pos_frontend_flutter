import 'package:flutter/material.dart';
import 'package:mini_pos/_application/extension/context.dart';

import '../../ui/ui.dart';

class HomeScren extends StatelessWidget {
  const HomeScren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Mini POS",
      ),
      drawer: Drawer(backgroundColor: context.primaryColor),
      body: const Center(
        child: Text("home"),
      ),
    );
  }
}
