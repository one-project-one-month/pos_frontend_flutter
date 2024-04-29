import 'package:flutter/material.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/_application/services/storage/storage_service.dart';
import 'package:mini_pos/staff/staff.dart';
import 'package:provider/provider.dart';

class MainController {
  void setUp(BuildContext context) {}

  Future<void> checkStaffInfo(BuildContext context) async {
    final String? token = await StorageService.I.readData(key: "authToken");

    if (token == null) {
      await context.toNamed(fullPath: loginScreen);
      return;
    }
    context.read<StaffProvider>().checkStaffInfo(token, context);
  }
}
