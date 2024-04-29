import 'package:flutter/material.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/categories/categories.dart';
import 'package:mini_pos/ui/ui.dart';
import 'package:provider/provider.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Edit Category"),
      body: Consumer<EditCategoryProvider>(
        builder: (context, value, child) {
          return Form(
            key: value.formKey,
            child: Column(
              children: [
                20.height,
                _CusTextField(
                  enable: false,
                  validator: value.validator,
                  textEditingController: value.pCategoryCodeController,
                  hintText: "Enter Category category code",
                  label: "Category category code",
                ),
                20.height,
                _CusTextField(
                  validator: value.validator,
                  textEditingController: value.pNameController,
                  hintText: "Enter Category name",
                  label: "Category name",
                ),
                50.height,
                SizedBox(
                  width: context.dw,
                  height: 50,
                  child: ElevatedButton(
                    style: Theme.of(context).elevatedButtonTheme.style,
                    onPressed: value.editCategory,
                    child: const Text("Save"),
                  ),
                )
              ],
            ),
          ).paddingHorizontal(20);
        },
      ),
    );
  }
}

class _CusTextField extends StatelessWidget {
  const _CusTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.textEditingController,
    required this.validator,
    this.enable = true,
  });
  final String label;
  final String hintText;
  final TextEditingController textEditingController;
  final String? Function(String?) validator;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.titleSmall?.copyWith(
            color: Colors.black,
          ),
        ),
        10.height,
        TextFormField(
          enabled: enable,
          focusNode: FocusNode(),
          validator: validator,
          controller: textEditingController,
          style: context.textTheme.titleMedium?.copyWith(
            color: Colors.black,
          ),
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: context.primaryColor),
              borderRadius: BorderRadius.circular(5),
            ),
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
