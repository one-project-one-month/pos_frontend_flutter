import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/customers/customers.dart';
import 'package:mini_pos/ui/ui.dart';
import 'package:provider/provider.dart';

class EditCustomerScreen extends StatelessWidget {
  const EditCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Edit Customer"),
      body: SingleChildScrollView(
        child: Consumer<EditCustomerProvider>(
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
                          textEditingController: value.cNameController,
                          hintText: "Enter customer name",
                          label: "Customer name",
                        ),
                      ),
                      20.width,
                      Flexible(
                        child: _CusTextField(
                          validator: value.validator,
                          textEditingController: value.cCodeController,
                          hintText: "Enter customer code",
                          label: "Customer code",
                        ),
                      ),
                    ],
                  ),
                  20.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: _CusTextField(
                          validator: value.validator,
                          textEditingController: value.cTownshipCodeController,
                          hintText: "Enter township code",
                          label: "Township code",
                        ),
                      ),
                      20.width,
                      Flexible(
                        child: _CusTextField(
                          validator: value.validator,
                          textEditingController: value.cStateCodeController,
                          hintText: "Enter customer state code",
                          label: "State code",
                        ),
                      ),
                    ],
                  ),
                  20.height,
                  _CusTextField(
                    validator: value.validator,
                    textEditingController: value.cMobileNoController,
                    hintText: "Enter customer mobile number",
                    label: "Mobile number",
                  ),
                  20.height,
                  _CusTextField(
                    readOnly: true,
                    ontap: () async => await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return CupertinoDatePicker(
                          initialDateTime: DateTime.now().subtract(
                            const Duration(
                              days: 365 * 20,
                            ),
                          ),
                          maximumYear: DateTime.now().year - 18,
                          mode: CupertinoDatePickerMode.date,
                          use24hFormat: true,
                          onDateTimeChanged: value.setDOB,
                        );
                      },
                    ),
                    hintText: value.cDOB == null
                        ? "Date of birth"
                        : DateFormat("yyyy MMMM dd").format(
                            value.cDOB!,
                          ),
                    label: "Date of birth",
                  ),
                  // GestureDetector(
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //       vertical: 20,
                  //       horizontal: 10,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       border: Border.all(color: Colors.black),
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         const Text(
                  //           "Date of Birth",
                  //           style: TextStyle(
                  //             color: Colors.black,
                  //           ),
                  //         ),
                  //         Text(
                  //           value.cDOB == null
                  //               ? "None"
                  //               : DateFormat("yyyy-MM-dd").format(
                  //                   value.cDOB!,
                  //                 ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  50.height,
                  SizedBox(
                    width: context.dw,
                    height: 50,
                    child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: value.addCustomer,
                      child: const Text("Save"),
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
    this.isNumber = false,
    this.textEditingController,
    this.validator,
    this.ontap,
    this.readOnly = false,
  });
  final String label;
  final String hintText;
  final bool isNumber;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final VoidCallback? ontap;
  final bool readOnly;

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
