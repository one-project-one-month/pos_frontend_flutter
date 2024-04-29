import 'package:flutter/material.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/staff/staff.dart';

class StaffProvider extends ChangeNotifier {
  StaffModel? currentStaff;

  void setStaff(StaffModel staff) {
    currentStaff = staff;
    notifyListeners();
  }

  Future<void> checkStaffInfo(String staffToken, BuildContext context) async {
    const checkedStaff = StaffModel(
      stuffId: "01",
      stuffCode: "01",
      staffName: "staffName",
      dOB: "2003-10-03",
      mobileNumber: "0999999999",
      address: "Yangon",
      gender: "MALE",
      position: "Staff",
    );
    currentStaff = checkedStaff;
    notifyListeners();

    await context.toNamed(
      fullPath: home,
      redirect: false,
    );
  }
}
