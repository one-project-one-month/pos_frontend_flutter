import 'package:flutter/material.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/_application/services/storage/storage_service.dart';
import 'package:provider/provider.dart';

import '../../staff/staff.dart';

class LoginProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field can't be empty";
    }
    return null;
  }

  void login(BuildContext context) {
    final isSuccess = formKey.currentState?.validate();
    if (isSuccess == null || !isSuccess) {
      return;
    }

    const dummyStuff = StaffModel(
      stuffId: "01",
      stuffCode: "01",
      staffName: "staffName",
      dOB: "2003-10-03",
      mobileNumber: "0999999999",
      address: "Yangon",
      gender: "MALE",
      position: "Staff",
    );

    context.read<StaffProvider>().setStaff(dummyStuff);
    StorageService.I.storeData(key: "authToken", data: "test");
    context.toNamed(fullPath: home, redirect: false);
  }
}
