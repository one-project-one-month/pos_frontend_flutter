// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  final String productId;
  final String productCode;
  final String productName;
  final double price;
  final String productCategoryCode;
  final String image;
  int? quantity;

  ProductModel({
    required this.productId,
    required this.productCode,
    required this.productName,
    required this.price,
    required this.productCategoryCode,
    required this.image,
    this.quantity,
  });
}
