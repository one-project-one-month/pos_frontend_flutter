import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_pos/products/products.dart';
import 'package:mini_pos/util/util.dart';

import '../../_application/application.dart';

class ProductProvider extends ChangeNotifier {
  final productList = <ProductModel>[];
  final selectedProductList = <ProductModel>[];
  double totalPrice = 0.0;

  ApiStatus getProductListStatus = ApiStatus.initial;

  final TextEditingController quantityController = TextEditingController();

  void updateGetProductListStatus(ApiStatus status) {
    getProductListStatus = status;
    notifyListeners();
  }

  void updateProductList({List<ProductModel>? list, ProductModel? product}) {
    if (list != null) {
      productList.clear();
      productList.addAll(list);
    }

    if (product != null) {
      productList.add(product);
    }

    notifyListeners();
  }

  Future<void> showBrowseProductButtomSheet(BuildContext context) async {
    if (productList.isEmpty) {
      getProductList();
    }
    await showModalBottomSheet(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          height: context.dh * 0.8,
          child: const ProductScreenWidget().paddingVertical(20),
        );
      },
    );
  }

  Future<void> addQuantityBottomSheet(
      ProductModel product, BuildContext context) async {
    await showModalBottomSheet(
      backgroundColor: context.primaryColor,
      context: context,
      builder: (context) {
        quantityController.text = product.quantity.toString();
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    subtractOneQuantity(product);
                  },
                  child: const CircleAvatar(
                    radius: 15,
                    child: Icon(
                      Icons.remove,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.primaryColor,
                    ),
                    onEditingComplete: () {
                      addProductQuantity(
                        int.parse(
                          quantityController.text,
                        ),
                        product,
                      );
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    addOneQuantity(product);
                  },
                  child: const CircleAvatar(
                    radius: 15,
                    child: Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void addOneQuantity(ProductModel product) {
    var existingProduct = productList.firstWhereOrNull((p) => p == product);
    if (existingProduct != null) {
      existingProduct.quantity += 1;
      quantityController.text = existingProduct.quantity.toString();
      addToSelectedProductList(existingProduct);
      notifyListeners();
    }
  }

  void subtractOneQuantity(ProductModel product) {
    var existingProduct = productList.firstWhereOrNull((p) => p == product);
    if (existingProduct != null && existingProduct.quantity > 0) {
      existingProduct.quantity -= 1;
      quantityController.text = existingProduct.quantity.toString();
      addToSelectedProductList(existingProduct);
      notifyListeners();
    }
  }

  void addProductQuantity(int quantity, ProductModel product) {
    var existingProduct = productList.firstWhereOrNull((p) => p == product);
    if (existingProduct != null) {
      existingProduct.quantity = quantity;
      addToSelectedProductList(existingProduct);
      notifyListeners();
    }
  }

  Future<void> getProductList() async {
    updateGetProductListStatus(ApiStatus.loading);

    Future.delayed(const Duration(seconds: 2), () {
      final list = [
        ProductModel(
          productId: "001",
          productCode: "001",
          productName: "MAMA",
          price: 500,
          productCategoryCode: "001",
          image:
              "https://m.media-amazon.com/images/I/917UUp3HL5L._AC_UF894,1000_QL80_.jpg",
        ),
        ProductModel(
          productId: "002",
          productCode: "002",
          productName: "Coca Cola",
          price: 700,
          productCategoryCode: "002",
          image:
              "https://e7.pngegg.com/pngimages/36/500/png-clipart-coca-cola-car-product-design-coca-cola-car-cola.png",
        ),
        ProductModel(
          productId: "003",
          productCode: "003",
          productName: "Shark",
          price: 1500,
          productCategoryCode: "003",
          image:
              "https://i0.wp.com/lifeplusmm.com/wp-content/uploads/2022/09/10101007_Shark-Energy-Drink-Can-250ml.png?fit=600%2C900&ssl=1",
        ),
        ProductModel(
          productId: "004",
          productCode: "004",
          productName: "Tiger",
          price: 1500,
          productCategoryCode: "004",
          image:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToZ8i3HUP1JlEY67XGb64_4nUkqEhGU0KxFPs5w-ANZg&s",
        ),
      ];
      updateProductList(list: list);
      updateGetProductListStatus(ApiStatus.complete);
    });
  }

  void addToSelectedProductList(ProductModel product) {
    if (product.quantity > 0) {
      var existingProduct = selectedProductList
          .firstWhereOrNull((p) => p.productCode == product.productCode);
      if (existingProduct != null) {
        existingProduct.quantity = product.quantity;
      } else {
        selectedProductList.add(product);
      }
    } else {
      selectedProductList
          .removeWhere((p) => p.productCode == product.productCode);
    }

    updateTotalPrice();
    notifyListeners();
  }

  void showRemoveDialog(BuildContext context, ProductModel model) {
    showAlertBox(context,
        child: Column(
          children: [
            const Text("Are you sure to remove this product"),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text("NO")),
                ElevatedButton(
                    onPressed: () {
                      removeProduct(model);
                      context.pop();
                    },
                    child: const Text("YES"))
              ],
            )
          ],
        ));
  }

  void removeProduct(ProductModel model) {
    selectedProductList.remove(model);
    notifyListeners();
  }

  void updateTotalPrice() {
    totalPrice = selectedProductList.fold(
      0.0,
      (prev, element) => prev + (element.price * element.quantity),
    );
    notifyListeners();
  }

  int getTotalQty() {
    return selectedProductList.fold(
        0, (prev, element) => prev + element.quantity);
  }
}

extension IterableExtensions<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
