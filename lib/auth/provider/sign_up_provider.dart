import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  DateTime? dOB;
  final nameController = TextEditingController();
  final staffCodeController = TextEditingController();
  final addressController = TextEditingController();
  String? gender;

  void setGender(String gender) {
    debugPrint(
      "--------------------- set gender called $gender ------------------",
    );
    this.gender = gender;
    notifyListeners();
  }

  void setDOB(DateTime dOB) {
    this.dOB = dOB;
    notifyListeners();
  }
}
