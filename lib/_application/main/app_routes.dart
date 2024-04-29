import 'package:flutter/material.dart';
import 'package:mini_pos/categories/categories.dart';
import 'package:mini_pos/customers/customers.dart';
import 'package:mini_pos/products/products.dart';

import '../../transaction/transaction.dart';
import '../application.dart';

Route<dynamic>? appRoutes(RouteSettings settings) {
  switch (settings.name) {
    case transcationScreen:
      return MaterialPageRoute(builder: (context) {
        final arguments = settings.arguments as Map<String, dynamic>;
        return TransactionScreen(
          totalPrice: arguments["totalPrice"],
          totalQty: arguments["totalQty"],
          selectedProductList: arguments["selectedProductList"],
        );
      });

    case addProductScreen:
      return MaterialPageRoute(builder: (context) {
        return const AddProductScreen();
      });
    case editProductScreen:
      return MaterialPageRoute(builder: (context) {
        return const EditProductScreen();
      });
    case addCategoryScreen:
      return MaterialPageRoute(builder: (context) {
        return const AddCategoryScreen();
      });
    case editCategoryScreen:
      return MaterialPageRoute(builder: (context) {
        return const EditCategoryScreen();
      });
    case addCustomerScreen:
      return MaterialPageRoute(builder: (context) {
        return const AddCustomerScreen();
      });
    case editCustomerScreen:
      return MaterialPageRoute(builder: (context) {
        return const EditCustomerScreen();
      });
  }
  return null;
}
