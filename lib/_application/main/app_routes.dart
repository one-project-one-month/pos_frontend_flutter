import 'package:flutter/material.dart';

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
  }
  return null;
}
