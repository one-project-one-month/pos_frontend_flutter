import 'package:flutter/material.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/products/products.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
    required this.productList,
    this.selectedProductsToDelete = const [],
    this.trailingOnTap,
    this.trailindWidget,
    this.isFileredList = false,
    this.isProductScreen = false,
    this.selectFunction,
    this.goToEditScreen,
  });

  final void Function(ProductModel model)? trailingOnTap;
  final Widget? trailindWidget;
  final bool isFileredList;
  final List<ProductModel> productList;
  final bool isProductScreen;
  final List<ProductModel> selectedProductsToDelete;
  final void Function(ProductModel model)? selectFunction;
  final void Function(ProductModel model)? goToEditScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isFileredList)
          Row(
            children: [
              Text.rich(
                TextSpan(children: [
                  const TextSpan(text: "Product Found: "),
                  TextSpan(text: productList.length.toString())
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
            final product = productList[index];

            return GestureDetector(
              onTap: selectedProductsToDelete.isNotEmpty
                  ? () {
                      selectFunction?.call(product);
                    }
                  : () {
                      if (isProductScreen) {
                        goToEditScreen?.call(product);
                      }
                    },
              onLongPress: isProductScreen
                  ? () {
                      selectFunction?.call(product);
                    }
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //! if product has image
                  // SizedBox(
                  //   width: 50,
                  //   child: Stack(
                  //     alignment: Alignment.bottomRight,
                  //     clipBehavior: Clip.none,
                  //     children: [
                  //       if (product.image != null)
                  //         CachedNetworkImage(
                  //           width: 50,
                  //           height: 50,
                  //           fit: BoxFit.cover,
                  //           progressIndicatorBuilder: (context, url, progress) {
                  //             return const CircularProgressIndicator();
                  //           },
                  //           imageUrl: product.image!,
                  //         )
                  //       else
                  //         const Icon(CupertinoIcons.cart, size: 50),
                  //       if (product.quantity != 0)
                  //         Positioned(
                  //           right: -10,
                  //           child: CircleAvatar(
                  //             backgroundColor: context.primaryColor,
                  //             radius: 12,
                  //             child: Text(
                  //               product.quantity < 100
                  //                   ? product.quantity.toString()
                  //                   : "99+",
                  //               style: context.textTheme.labelSmall?.copyWith(
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //     ],
                  //   ),
                  // ),
                  30.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${product.productName} (${product.productCode})",
                          style: context.textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        if (product.quantity != 0)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Qty    : ${product.quantity}",
                                style: context.textTheme.labelLarge?.copyWith(
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              Text(
                                "Price : ${product.price}  x ${product.quantity} = ${product.price * product.quantity.toInt()} MMK",
                                style: context.textTheme.labelLarge?.copyWith(
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            ],
                          )
                        else
                          Text(
                            "Price Per One: ${product.price} MMK",
                            style: context.textTheme.labelLarge?.copyWith(
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (selectedProductsToDelete.isNotEmpty)
                    Checkbox(
                      value: selectedProductsToDelete.contains(product),
                      onChanged: (val) {
                        selectFunction?.call(product);
                      },
                    )
                  else
                    GestureDetector(
                      onTap: () {
                        trailingOnTap?.call(product);
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
          itemCount: productList.length,
        ),
      ],
    );
  }
}
