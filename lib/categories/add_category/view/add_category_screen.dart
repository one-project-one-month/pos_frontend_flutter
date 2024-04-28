import 'package:flutter/material.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/products/products.dart';
import 'package:mini_pos/ui/ui.dart';
import 'package:provider/provider.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddProductProvider(),
      child: Scaffold(
        appBar: const CustomAppBar(title: "Add Product"),
        body: Consumer<AddProductProvider>(
          builder: (context, value, child) {
            return Form(
              key: value.formKey,
              child: Column(
                children: [
                  20.height,
                  _CusTextField(
                    validator: value.validator,
                    textEditingController: value.pCodeController,
                    hintText: "Enter product code",
                    label: "Product code",
                  ),
                  20.height,
                  _CusTextField(
                    validator: value.validator,
                    textEditingController: value.pNameController,
                    hintText: "Enter product name",
                    label: "Product name",
                  ),
                  50.height,
                  SizedBox(
                    width: context.dw,
                    height: 50,
                    child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: value.addProduct,
                      child: const Text("Add"),
                    ),
                  )
                ],
              ),
            ).paddingHorizontal(20);
          },
        ),
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
  });
  final String label;
  final String hintText;
  final TextEditingController textEditingController;
  final String? Function(String?) validator;

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
