import 'package:flutter/material.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/products/products.dart';
import 'package:mini_pos/ui/ui.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (context.read<ProductProvider>().productList.isEmpty) {
        Provider.of<ProductProvider>(context, listen: false).getProductList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: DeleteAppBar(
            didSelectAll: value.didSelectAll,
            cancelFunction: value.cancelFunction,
            deleteFunction: value.deleteFunction,
            selectAllFunction: value.selectAllFunction,
            selectedProductsToDelete: value.selectedProductToDelete,
            customAppBar: CustomAppBar(
              title: "MINI POS",
              actions: [
                GestureDetector(
                  onTap: () {
                    context.toNamed(fullPath: addProductScreen);
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
          body: const ProductScreenWidget(),
        );
      },
    );
  }
}
