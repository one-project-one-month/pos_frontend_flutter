import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/products/products.dart';
import 'package:mini_pos/ui/ui.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Edit Product"),
      body: Consumer<EditProductProvider>(
        builder: (context, value, child) {
          return Form(
            key: value.formKey,
            child: Column(
              children: [
                20.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: _CusTextField(
                        validator: value.validator,
                        textEditingController: value.pCodeController,
                        hintText: "Enter product code",
                        enable: false,
                        label: "Product code",
                      ),
                    ),
                    20.width,
                    Flexible(
                      child: _CusTextField(
                        enable: false,
                        validator: value.validator,
                        textEditingController: value.pCategoryCodeController,
                        hintText: "Enter product category code",
                        label: "Product category code",
                      ),
                    ),
                  ],
                ),
                20.height,
                _CusTextField(
                  validator: value.validator,
                  textEditingController: value.pNameController,
                  hintText: "Enter product name",
                  label: "Product name",
                ),
                20.height,
                _CusTextField(
                  validator: value.validator,
                  textEditingController: value.pPriceController,
                  isNumber: true,
                  hintText: "Enter product price",
                  label: "Product price",
                ),
                50.height,
                SizedBox(
                  width: context.dw,
                  height: 50,
                  child: ElevatedButton(
                    style: Theme.of(context).elevatedButtonTheme.style,
                    onPressed: value.addProduct,
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
    this.isNumber = false,
    required this.textEditingController,
    required this.validator,
    this.enable = true,
  });
  final String label;
  final String hintText;
  final bool isNumber;
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
          keyboardType: isNumber ? TextInputType.number : null,
          style: context.textTheme.titleMedium?.copyWith(
            color: Colors.black,
          ),
          inputFormatters:
              isNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
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
