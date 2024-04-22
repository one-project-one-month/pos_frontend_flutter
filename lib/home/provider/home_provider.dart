import 'package:flutter/material.dart';

import '../../products/products.dart';

class HomeProvider extends ChangeNotifier {
  final selectedProductList = List.generate(
    10,
    (index) => ProductModel(
      image:
          "https://m.media-amazon.com/images/I/917UUp3HL5L._AC_UF894,1000_QL80_.jpg",
      productId: "001",
      productCode: "001",
      productName: "Mama",
      price: 500,
      quantity: 5,
      productCategoryCode: "001",
    ),
  );

  double getTotalPrice() {
    double totalPrice = 0.0;
    for (var element in selectedProductList) {
      totalPrice += element.price;
    }

    return totalPrice;
  }

  int getTotalQty() {
    int totalPrice = 0;
    for (var element in selectedProductList) {
      totalPrice += element.quantity!;
    }

    return totalPrice;
  }
}
