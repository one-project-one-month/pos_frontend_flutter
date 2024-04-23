import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_pos/products/products.dart';
import 'package:mini_pos/ui/ui.dart';
import 'package:provider/provider.dart';

import '../../_application/application.dart';

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
        }
        return SingleChildScrollView(
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
                  labelText: "Search Product",
                ),
              ),
              20.height,
              ProductList(
                trailindWidget:
                    const Icon(Icons.shopping_cart_checkout_outlined),
                selectedProductList: value.productList,
                trailingOnTap: (model) =>
                    value.addQuantityBottomSheet(model, context),
              ),
            ],
          ).paddingHorizontal(20),
        );
      },
    );
  }
}
