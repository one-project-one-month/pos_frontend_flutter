import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/ui/ui.dart';
import 'package:provider/provider.dart';

import '../home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = HomeProvider();
    return ChangeNotifierProvider.value(
      value: homeProvider,
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("Total Price"),
                trailing: Text(
                  "${homeProvider.getTotalPrice()} MMK",
                  style: context.textTheme.labelLarge,
                ),
              ),
              SizedBox(
                width: context.dw,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.toNamed(
                      fullPath: transcationScreen,
                      arguments: {
                        "selectedProductList": homeProvider.selectedProductList,
                        "totalPrice": homeProvider.getTotalPrice(),
                        "totalQty": homeProvider.getTotalQty()
                      },
                    );
                  },
                  icon: const Icon(Icons.print_outlined),
                  label: const Text("Go To Transaction"),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                focusNode: FocusNode(),
                onTapOutside: (event) {
                  FocusScopeNode().unfocus();
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                  labelText: "Search Product (Using Product Code)",
                ),
              ),
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: context.dh * 0.06,
                    width: context.dw * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: context.primaryColor,
                    ),
                    child: const Center(
                      child: Text("Browse Products"),
                    ),
                  ),
                  Container(
                    height: context.dh * 0.06,
                    width: context.dw * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: context.primaryColor,
                    ),
                    child: const Center(
                      child: Text(
                        "Choose Customer (Optional)",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              20.height,
              if (homeProvider.selectedProductList.isEmpty)
                Column(
                  children: [
                    LottieBuilder.asset(noTransaction),
                    Text(
                      "No products are selected to process transaction.",
                      style: context.textTheme.bodyLarge
                          ?.copyWith(color: Colors.black),
                    ),
                  ],
                )
              else
                SelectedProductList(
                  selectedProductList: homeProvider.selectedProductList,
                )
            ],
          ).paddingAll(20),
        ),
      ),
    );
  }
}
