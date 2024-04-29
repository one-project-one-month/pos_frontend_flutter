import 'package:flutter/material.dart';

class AddCustomerProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final cCodeController = TextEditingController();
  final cNameController = TextEditingController();
  final cMobileNoController = TextEditingController();
  DateTime? cDOB;
  final cGenderController = TextEditingController();
  final cStateCodeController = TextEditingController();
  final cTownshipCodeController = TextEditingController();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field can't be empty";
    }
    return null;
  }

  void setDOB(DateTime value) {
    cDOB = value;
    notifyListeners();
  }

  void addCustomer() {
    final isSuccess = formKey.currentState?.validate();
    if (isSuccess == null || !isSuccess) {
      return;
    }
  }
}
