import 'package:flutter/material.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/categories/categories.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.categoryList,
    this.selectedcategorysToDelete = const [],
    this.trailingOnTap,
    this.trailindWidget,
    this.isFileredList = false,
    this.selectFunction,
    this.goToEditScreen,
  });

  final void Function(CategoryModel model)? trailingOnTap;
  final Widget? trailindWidget;
  final bool isFileredList;
  final List<CategoryModel> categoryList;
  final List<CategoryModel> selectedcategorysToDelete;
  final void Function(CategoryModel model)? selectFunction;
  final void Function(CategoryModel model)? goToEditScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isFileredList)
          Row(
            children: [
              Text.rich(
                TextSpan(children: [
                  const TextSpan(text: "Categories Found: "),
                  TextSpan(text: categoryList.length.toString())
                ]),
                style: context.textTheme.titleSmall?.copyWith(
                  color: Colors.black,
                ),
              )
            ],
          ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final category = categoryList[index];

            return GestureDetector(
              onTap: selectedcategorysToDelete.isNotEmpty
                  ? () {
                      selectFunction?.call(category);
                    }
                  : () {
                      goToEditScreen?.call(category);
                    },
              onLongPress: () {
                selectFunction?.call(category);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  30.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Category Name : ${category.productCategoryName} ",
                          style: context.textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Category Code :  ${category.productCategoryCode} ",
                          style: context.textTheme.titleMedium?.copyWith(
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (selectedcategorysToDelete.isNotEmpty)
                    Checkbox(
                      value: selectedcategorysToDelete.contains(category),
                      onChanged: (val) {
                        selectFunction?.call(category);
                      },
                    )
                  else
                    GestureDetector(
                      onTap: () {
                        trailingOnTap?.call(category);
                      },
                      child: trailindWidget ?? 50.width,
                    ),
                ],
              ).paddingVertical(10),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: categoryList.length,
        ),
      ],
    );
  }
}
