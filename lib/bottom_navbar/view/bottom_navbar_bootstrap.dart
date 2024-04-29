import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:provider/provider.dart';

import '../bottom_navbar.dart';

class BottomNavbarBootstrap extends StatelessWidget {
  const BottomNavbarBootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavbarProvider = Provider.of<BottomNavbarProvider>(context);
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.white),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            enableFeedback: false,
            currentIndex: bottomNavbarProvider.currentIndex,
            onTap: bottomNavbarProvider.navbarOntap,
            selectedFontSize: 12,
            selectedItemColor: context.primaryColor,
            unselectedItemColor: context.secondaryColor,
            items: [
              const BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home_outlined),
              ),
              const BottomNavigationBarItem(
                label: "Products",
                icon: Icon(Icons.shopping_cart_outlined),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: FloatingActionButton(
                  backgroundColor: context.primaryColor,
                  foregroundColor: Colors.white,
                  shape: const CircleBorder(),
                  onPressed: () {},
                  child: const Icon(Icons.person),
                ),
              ),
              const BottomNavigationBarItem(
                label: "Categories",
                icon: Icon(CupertinoIcons.rectangle_grid_2x2),
              ),
              const BottomNavigationBarItem(
                label: "Customers",
                icon: Icon(CupertinoIcons.person_3),
              ),
            ]),
      ),
      body: bottomNavbarProvider
          .bottomNavbarWidgets[bottomNavbarProvider.currentIndex],
    );
  }
}
