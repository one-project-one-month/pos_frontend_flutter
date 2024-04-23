import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/products/products.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
    required this.selectedProductList,
    this.trailingOnTap,
    this.trailindWidget,
  });

  final List<ProductModel> selectedProductList;
  final void Function(ProductModel model)? trailingOnTap;
  final Widget? trailindWidget;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final product = selectedProductList[index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 50,
              child: Stack(
                alignment: Alignment.bottomRight,
                clipBehavior: Clip.none,
                children: [
                  CachedNetworkImage(
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, progress) {
                      return const CircularProgressIndicator();
                    },
                    imageUrl: product.image,
                  ),
                  if (product.quantity != 0)
                    Positioned(
                      right: -10,
                      child: CircleAvatar(
                        backgroundColor: context.primaryColor,
                        radius: 12,
                        child: Text(
                          product.quantity < 100
                              ? product.quantity.toString()
                              : "99+",
                          style: context.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            30.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
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
                      "Price Per One: ${product.price}",
                      style: context.textTheme.labelLarge?.copyWith(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                trailingOnTap?.call(product);
              },
              child: trailindWidget ?? 50.width,
            ),
          ],
        ).paddingVertical(10);
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: selectedProductList.length,
    );
  }
}
