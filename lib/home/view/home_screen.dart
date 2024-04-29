import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/customers/customers.dart';
import 'package:mini_pos/products/products.dart';
import 'package:mini_pos/ui/ui.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(title: "MINI POS"),
      bottomNavigationBar: productProvider.selectedProductList.isNotEmpty
          ? Container(
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
                      "${productProvider.totalPrice} MMK",
                      style: context.textTheme.labelLarge,
                    ),
                  ),
                  SizedBox(
                    width: context.dw,
                    child: ElevatedButton.icon(
                      style:
                          Theme.of(context).elevatedButtonTheme.style?.copyWith(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                              ),
                      onPressed: () {
                        context.toNamed(
                          fullPath: transcationScreen,
                          arguments: {
                            "selectedProductList":
                                productProvider.selectedProductList,
                            "totalPrice": productProvider.totalPrice,
                            "totalQty": productProvider.getTotalQty()
                          },
                        );
                      },
                      icon: const Icon(Icons.print_outlined),
                      label: const Text("Go To Invoice"),
                    ),
                  ),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    productProvider.showBrowseProductButtomSheet(context);
                  },
                  child: Container(
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
                ),
                GestureDetector(
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        final customerProvider =
                            context.watch<CustomerProvider>();
                        if (customerProvider.customerList.isEmpty) {
                          context.read<CustomerProvider>().getCustomerList();
                        }
                        return SizedBox(
                          height: context.dh * 0.6,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              if (customerProvider.getProductListStatus ==
                                  ApiStatus.loading)
                                Lottie.asset(loading)
                              else
                                ...customerProvider.customerList.map((e) {
                                  return SelectContainer(
                                    isSelected:
                                        e == customerProvider.selectedCustomer,
                                    label:
                                        "${e.customerName} (${e.customerCode})",
                                    selectFunction: (val) {
                                      customerProvider.setSelectedCustomer(e);
                                    },
                                  );
                                })
                            ],
                          ).paddingVertical(20), // Move paddingVertical to here
                        );
                      },
                    );
                  },
                  child: Container(
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
                ),
              ],
            ),
            20.height,
            if (productProvider.selectedProductList.isEmpty)
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
              ProductList(
                trailindWidget: const Icon(Icons.close),
                productList: productProvider.selectedProductList,
                trailingOnTap: (model) => productProvider.showRemoveDialog(
                  context,
                  model,
                ),
              )
          ],
        ).paddingAll(20),
      ),
    );
  }
}
