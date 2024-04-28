import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mini_pos/categories/categories.dart';
import 'package:provider/provider.dart';

import '../../../_application/application.dart';

class CategoryProvider extends ChangeNotifier {
  final categoryList = <CategoryModel>[];
  final selectedCategoryToDelete = <CategoryModel>[];
  final searchedCategoryList = <CategoryModel>[];
  final searchController = TextEditingController();
  final searchFocus = FocusNode();
  bool isFound = true;
  bool didSelectAll = false;

  final _debouncer = Debouncer(milliseconds: 1000);

  ApiStatus getCategoryListStatus = ApiStatus.initial;

  final TextEditingController quantityController = TextEditingController();

  void updateGetProductListStatus(ApiStatus status) {
    getCategoryListStatus = status;
    notifyListeners();
  }

  void searchCategory(String value) {
    // Early exit if value is empty

    _debouncer.run(() {
      if (value.isEmpty) {
        isFound = true;
        searchedCategoryList.clear();
        notifyListeners();
        return;
      }
      debugPrint("--------------------- run ------------------");
      final lowerCaseValue = value.toLowerCase();
      final searchList = categoryList
          .where(
            (element) =>
                element.productCategoryCode == value ||
                element.productCategoryName
                    .toLowerCase()
                    .contains(lowerCaseValue),
          )
          .toList();

      isFound = searchList.isNotEmpty;
      searchedCategoryList
        ..clear()
        ..addAll(searchList);

      // Move focus request outside of debouncer
      searchFocus.requestFocus();
      notifyListeners();
    });
  }

  void updateProductList({List<CategoryModel>? list, CategoryModel? product}) {
    if (list != null) {
      categoryList.clear();
      categoryList.addAll(list);
    }

    if (product != null) {
      categoryList.add(product);
    }

    notifyListeners();
  }

  Future<void> getCategoryList() async {
    updateGetProductListStatus(ApiStatus.loading);

    Future.delayed(const Duration(seconds: 2), () {
      final list = [
        const CategoryModel(
          productCategoryCode: "001",
          productCategoryId: "001",
          productCategoryName: "Test",
        ),
        const CategoryModel(
          productCategoryCode: "002",
          productCategoryId: "002",
          productCategoryName: "Test 2",
        ),
        const CategoryModel(
          productCategoryCode: "003",
          productCategoryId: "003",
          productCategoryName: "Test 3",
        ),
        const CategoryModel(
          productCategoryCode: "004",
          productCategoryId: "004",
          productCategoryName: "Test 4",
        ),
        const CategoryModel(
          productCategoryCode: "005",
          productCategoryId: "005",
          productCategoryName: "Test 5",
        ),
        const CategoryModel(
          productCategoryCode: "006",
          productCategoryId: "006",
          productCategoryName: "Test 6",
        ),
      ];
      updateProductList(list: list);
      updateGetProductListStatus(ApiStatus.complete);
    });
  }

  void selectFunction(CategoryModel model) {
    if (!selectedCategoryToDelete.contains(model)) {
      selectedCategoryToDelete.add(model);
    } else {
      selectedCategoryToDelete.remove(model);
    }
    notifyListeners();
  }

  void cancelFunction() {
    debugPrint("--------------------- call ------------------");
    didSelectAll = false;
    selectedCategoryToDelete.clear();
    notifyListeners();
  }

  void selectAllFunction() {
    debugPrint("--------------------- call ------------------");
    didSelectAll = true;
    selectedCategoryToDelete.addAll(categoryList);
    notifyListeners();
  }

  void deleteFunction() {
    debugPrint("--------------------- call ------------------");

    for (var element in selectedCategoryToDelete) {
      categoryList.remove(element);
    }
    selectedCategoryToDelete.clear();
    notifyListeners();
  }

  void gotoEditScreen(BuildContext context, CategoryModel catrgory) {
    context.read<EditCategoryProvider>()
      ..pCategoryCodeController.text = catrgory.productCategoryCode
      ..pNameController.text = catrgory.productCategoryName;
    context.toNamed(fullPath: editCategoryScreen);
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
