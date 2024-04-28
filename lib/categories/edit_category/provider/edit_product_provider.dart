import 'package:flutter/material.dart';

class EditCategoryProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final pNameController = TextEditingController();
  final pCategoryCodeController = TextEditingController();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field can't be empty";
    }
    return null;
  }

  void editCategory() {
    final isSuccess = formKey.currentState?.validate();
    if (isSuccess == null || !isSuccess) {
      return;
    }
  }
}
