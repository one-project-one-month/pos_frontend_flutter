import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_pos/_application/application.dart';

class CusTextField extends StatelessWidget {
  const CusTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.isNumber = false,
    this.textEditingController,
    this.validator,
    this.ontap,
    this.readOnly = false,
    this.enable = true,
    this.isSecret = false,
  });
  final String label;
  final String hintText;
  final bool isNumber;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final VoidCallback? ontap;
  final bool readOnly;
  final bool enable;
  final bool isSecret;

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
          obscureText: isSecret,
          enabled: enable,
          readOnly: readOnly,
          onTap: ontap,
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
