import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mini_pos/customers/customers.dart';
import 'package:provider/provider.dart';

import '../../../_application/application.dart';

class CustomerProvider extends ChangeNotifier {
  final customerList = <CustomerModel>[];
  final selectedCustomerToDelete = <CustomerModel>[];
  final searchedCustomerList = <CustomerModel>[];
  final searchController = TextEditingController();
  final searchFocus = FocusNode();
  bool isFound = true;
  bool didSelectAll = false;

  final _debouncer = Debouncer(milliseconds: 1000);

  ApiStatus getProductListStatus = ApiStatus.initial;

  final TextEditingController quantityController = TextEditingController();

  void updateGetProductListStatus(ApiStatus status) {
    getProductListStatus = status;
    notifyListeners();
  }

  void searchProduct(String value) {
    // Early exit if value is empty

    _debouncer.run(() {
      if (value.isEmpty) {
        isFound = true;
        searchedCustomerList.clear();
        notifyListeners();
        return;
      }
      debugPrint("--------------------- run ------------------");
      final lowerCaseValue = value.toLowerCase();
      final searchList = customerList
          .where((element) =>
              element.customerCode == value ||
              element.customerName.toLowerCase().contains(lowerCaseValue))
          .toList();

      isFound = searchList.isNotEmpty;
      searchedCustomerList
        ..clear()
        ..addAll(searchList);

      // Move focus request outside of debouncer
      searchFocus.requestFocus();
      notifyListeners();
    });
  }

  void updateProductList({List<CustomerModel>? list, CustomerModel? product}) {
    if (list != null) {
      customerList.clear();
      customerList.addAll(list);
    }

    if (product != null) {
      customerList.add(product);
    }

    notifyListeners();
  }

  Future<void> getCustomerList() async {
    updateGetProductListStatus(ApiStatus.loading);

    Future.delayed(const Duration(seconds: 2), () {
      final list = <CustomerModel>[
        const CustomerModel(
          customerId: "001",
          customerCode: "001",
          customerName: "TMK",
          mobileNo: "09999999999",
          dateOfBirth: "2023-10-03",
          gender: "MALE",
          stateCode: "11011",
          townshipCode: "11011",
        ),
        const CustomerModel(
          customerId: "002",
          customerCode: "002",
          customerName: "TMK 2",
          mobileNo: "09999999999",
          dateOfBirth: "2023-10-03",
          gender: "MALE",
          stateCode: "11011",
          townshipCode: "11011",
        ),
      ];
      updateProductList(list: list);
      updateGetProductListStatus(ApiStatus.complete);
    });
  }

  void selectFunction(CustomerModel model) {
    if (!selectedCustomerToDelete.contains(model)) {
      selectedCustomerToDelete.add(model);
    } else {
      selectedCustomerToDelete.remove(model);
    }

    if (selectedCustomerToDelete.length == customerList.length) {
      didSelectAll = true;
    } else {
      didSelectAll = false;
    }
    notifyListeners();
  }

  void cancelFunction() {
    debugPrint("--------------------- call ------------------");
    didSelectAll = false;
    selectedCustomerToDelete.clear();
    notifyListeners();
  }

  void selectAllFunction() {
    debugPrint("--------------------- call ------------------");
    didSelectAll = true;
    selectedCustomerToDelete.addAll(customerList);
    notifyListeners();
  }

  void deleteFunction() {
    debugPrint("--------------------- call ------------------");

    for (var element in selectedCustomerToDelete) {
      customerList.remove(element);
    }
    selectedCustomerToDelete.clear();
    notifyListeners();
  }

  void gotoEditScreen(BuildContext context, CustomerModel cusomer) {
    context.read<EditCustomerProvider>()
      ..cCodeController.text = cusomer.customerCode
      ..cDOB = DateTime.tryParse(cusomer.dateOfBirth)
      ..cGenderController.text = cusomer.gender
      ..cMobileNoController.text = cusomer.mobileNo
      ..cNameController.text = cusomer.customerName
      ..cStateCodeController.text = cusomer.stateCode
      ..cTownshipCodeController.text = cusomer.townshipCode;

    context.toNamed(fullPath: editCustomerScreen);
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

class Debouncer {
  final int milliseconds;
  Timer? _timer;
  Debouncer({required this.milliseconds});
  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
