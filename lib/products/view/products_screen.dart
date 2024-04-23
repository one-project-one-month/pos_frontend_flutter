import 'package:flutter/material.dart';
import 'package:mini_pos/products/products.dart';
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
    return const ProductScreenWidget();
  }
}
