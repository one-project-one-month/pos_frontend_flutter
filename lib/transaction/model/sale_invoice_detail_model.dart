class SaleInvoiceDetailModel {
  final String saleInvoiceDetailId;
  final String voucherNo;
  final String productCode;
  final int quantity;
  final String price;
  final String amount;

  const SaleInvoiceDetailModel({
    required this.saleInvoiceDetailId,
    required this.voucherNo,
    required this.productCode,
    required this.quantity,
    required this.price,
    required this.amount,
  });
}
