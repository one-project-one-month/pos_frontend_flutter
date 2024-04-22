import 'package:flutter/material.dart';
import 'package:mini_pos/staff/staff.dart';

import '../../_application/application.dart';

class StaffProvider extends ChangeNotifier {
  final staffs = <StaffModel>[];

  Future<void> getStaffs() async {
    final res = await ApiService.I.callApi(
      isAlreadyHaveToken: false,
    );

    final dummyStaffs = List.generate(
      5,
      (index) => StaffModel(
          stuffId: index.toString(),
          stuffCode: index.toString(),
          staffName: "Dummy Staff",
          dOB: "2003-10-03",
          mobileNumber: "09999999999",
          address: "Yangon",
          gender: "MALE",
          position: "STAFF"),
    );

    staffs.addAll(dummyStaffs);
    notifyListeners();
  }
}
