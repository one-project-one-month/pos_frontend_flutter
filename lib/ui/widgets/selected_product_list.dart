import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/products/products.dart';

class SelectedProductList extends StatelessWidget {
  const SelectedProductList({
    super.key,
    required this.selectedProductList,
    this.isFromTransaction = false,
  });

  final List<ProductModel> selectedProductList;
  final bool isFromTransaction;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final product = selectedProductList[index];
        return ListTile(
          leading: CachedNetworkImage(
            progressIndicatorBuilder: (context, url, progress) {
              return const CircularProgressIndicator();
            },
            imageUrl: product.image,
          ),
          title: Text(product.productName + index.toString()),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Quantity: ${product.quantity}"),
              Text(
                  "Price: ${product.price}  x ${product.quantity} = ${product.price * product.quantity!.toInt()} MMK"),
            ],
          ),
          trailing: !isFromTransaction
              ? IconButton(
                  onPressed: () {
                    //! TODO: remove selected product
                  },
                  icon: const Icon(Icons.close),
                )
              : const SizedBox(),
        ).paddingVertical(10);
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: selectedProductList.length,
    );
  }
}
