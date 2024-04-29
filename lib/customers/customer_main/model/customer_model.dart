class CustomerModel {
  final String customerId;
  final String customerCode;
  final String customerName;
  final String mobileNo;
  final String dateOfBirth;
  final String gender;
  final String stateCode;
  final String townshipCode;

  const CustomerModel({
    required this.customerId,
    required this.customerCode,
    required this.customerName,
    required this.mobileNo,
    required this.dateOfBirth,
    required this.gender,
    required this.stateCode,
    required this.townshipCode,
  });
}
