class SaleInvoiceModel {
  final String saleInvoiceId;
  final DateTime saleInvoiceDateTime;
  final String voucherNo;
  final String totalAmount;
  final int discount;
  final String staffCode;
  final String tax;
  final String paymentType;
  final String customerAccountNo;
  final String paymentAmount;
  final String receiveAmount;
  final String change;
  final String customerCode;

  const SaleInvoiceModel({
    required this.saleInvoiceId,
    required this.saleInvoiceDateTime,
    required this.voucherNo,
    required this.totalAmount,
    required this.discount,
    required this.staffCode,
    required this.tax,
    required this.paymentType,
    required this.customerAccountNo,
    required this.paymentAmount,
    required this.receiveAmount,
    required this.change,
    required this.customerCode,
  });
}
