import 'package:flutter/material.dart';
import 'package:mini_pos/home/home.dart';

import '../../categories/categories.dart';
import '../../customers/customers.dart';
import '../../products/products.dart';

class BottomNavbarProvider extends ChangeNotifier {
  int currentIndex = 0;

  List<Widget> bottomNavbarWidgets = [
    const HomeScreen(),
    const ProductScreen(),
    const Center(
      child: Text("Add"),
    ),
    const CategoriesScreen(),
    const CustomerScreen()
  ];

  void navbarOntap(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
