import 'package:flutter/material.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/categories/categories.dart';
import 'package:mini_pos/ui/ui.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (context.read<CategoryProvider>().categoryList.isEmpty) {
        Provider.of<CategoryProvider>(context, listen: false).getCategoryList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: DeleteAppBar(
            didSelectAll: value.didSelectAll,
            cancelFunction: value.cancelFunction,
            deleteFunction: value.deleteFunction,
            selectAllFunction: value.selectAllFunction,
            selectedProductsToDelete: value.selectedCategoryToDelete,
            customAppBar: CustomAppBar(
              title: "MINI POS",
              actions: [
                GestureDetector(
                  onTap: () {
                    context.toNamed(fullPath: addCategoryScreen);
                  },
                  child: CircleAvatar(
                    backgroundColor: context.primaryColor,
                    radius: 20,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ).paddingHorizontal(10),
                ),
              ],
            ),
          ),
          body: const CategoryScreenWidget(),
        );
      },
    );
  }
}
