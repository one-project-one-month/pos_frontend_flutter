import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_pos/categories/categories.dart';
import 'package:provider/provider.dart';

import '../../../_application/application.dart';

class CategoryScreenWidget extends StatelessWidget {
  const CategoryScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, value, child) {
        if (value.getCategoryListStatus == ApiStatus.loading) {
          return Center(
            child: LottieBuilder.asset(loading),
          );
        } else {
          return RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            displacement: 100,
            onRefresh: () async {
              value.getCategoryList();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: value.categoryList.isEmpty
                  ? Column(
                      children: [
                        LottieBuilder.asset(notFound),
                        Text(
                          "No Categories",
                          style: context.textTheme.bodyLarge
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    )
                  : Column(
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
                          onChanged: value.searchCategory,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.search),
                            labelText: "Search Category",
                          ),
                        ),
                        20.height,
                        if (!value.isFound)
                          Column(
                            children: [
                              LottieBuilder.asset(notFound),
                              Text(
                                "No searched categories are found.",
                                style: context.textTheme.bodyLarge
                                    ?.copyWith(color: Colors.black),
                              ),
                            ],
                          )
                        else
                          CategoryList(
                            goToEditScreen: (product) =>
                                value.gotoEditScreen(context, product),
                            selectFunction: value.selectFunction,
                            isFileredList:
                                value.searchedCategoryList.isNotEmpty,
                            selectedcategorysToDelete:
                                value.selectedCategoryToDelete,
                            categoryList: value.searchedCategoryList.isEmpty
                                ? value.categoryList
                                : value.searchedCategoryList,
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
