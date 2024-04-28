import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_pos/products/products.dart';
import 'package:mini_pos/ui/ui.dart';
import 'package:provider/provider.dart';

import '../../../_application/application.dart';

class ProductScreenWidget extends StatelessWidget {
  const ProductScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        if (value.getProductListStatus == ApiStatus.loading) {
          return Center(
            child: LottieBuilder.asset(loading),
          );
        } else {
          if (value.productList.isEmpty) {
            return Column(
              children: [
                LottieBuilder.asset(notFound),
                Text(
                  "No products",
                  style: context.textTheme.bodyLarge
                      ?.copyWith(color: Colors.black),
                ),
              ],
            );
          }
          return RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            displacement: 100,
            onRefresh: () async {
              value.getProductList();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  TextFormField(
                    style: context.textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                    ),
                    controller: value.searchController,
                    focusNode: value.searchFocus,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    onChanged: value.searchProduct,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                      labelText: "Search Product",
                    ),
                  ),
                  20.height,
                  if (!value.isFound)
                    Column(
                      children: [
                        LottieBuilder.asset(notFound),
                        Text(
                          "No searched products are found.",
                          style: context.textTheme.bodyLarge
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    )
                  else
                    ProductList(
                      goToEditScreen: (product) =>
                          value.gotoEditScreen(context, product),
                      isProductScreen: true,
                      selectFunction: value.selectFunction,
                      isFileredList: value.searchedProductList.isNotEmpty,
                      selectedProductsToDelete: value.selectedProductToDelete,
                      trailindWidget:
                          const Icon(Icons.shopping_cart_checkout_outlined),
                      productList: value.searchedProductList.isEmpty
                          ? value.productList
                          : value.searchedProductList,
                      trailingOnTap: (model) =>
                          value.addQuantityBottomSheet(model, context),
                    ),
                ],
              ).paddingHorizontal(20).paddingVertical(10),
            ),
          );
        }
      },
    );
  }
}
