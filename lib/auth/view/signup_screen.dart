import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/auth/auth.dart';
import 'package:mini_pos/ui/ui.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpProvider(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Consumer<SignUpProvider>(
            builder: (context, value, child) {
              return Column(
                children: [
                  LottieBuilder.asset(login),
                  Form(
                    child: Column(
                      children: [
                        20.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Flexible(
                              child: CusTextField(
                                hintText: "Enter name",
                                label: "Name",
                              ),
                            ),
                            20.width,
                            const Flexible(
                              child: CusTextField(
                                hintText: "Enter code",
                                label: "Staff code",
                              ),
                            ),
                          ],
                        ),
                        20.height,
                        const CusTextField(
                          hintText: "Enter mobile number",
                          label: "Mobile number",
                        ),
                        20.height,
                        const CusTextField(
                          hintText: "Enter Address",
                          label: "Address",
                        ),
                        20.height,
                        Row(
                          children: [
                            Flexible(
                              child: CusTextField(
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
                                hintText: value.dOB == null
                                    ? "Date of birth"
                                    : DateFormat("yyyy MMMM dd").format(
                                        value.dOB!,
                                      ),
                                label: "Date of birth",
                              ),
                            ),
                            20.width,
                            Flexible(
                              child: CusTextField(
                                readOnly: true,
                                ontap: () async => await showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ...["MALE", "FEMALE", "NON BINNARY"]
                                            .map((gender) {
                                          return SelectContainer(
                                            selectFunction: value.setGender,
                                            isSelected: value.gender
                                                    .toString()
                                                    .toLowerCase() ==
                                                gender.toLowerCase(),
                                            label: gender,
                                          );
                                        })
                                      ],
                                    );
                                  },
                                ),
                                hintText: value.gender == null
                                    ? "Gender"
                                    : value.gender!,
                                label: "Gender",
                              ),
                            ),
                          ],
                        ),
                        50.height,
                        Row(
                          children: [
                            Text(
                              "Already have an account?",
                              style: context.textTheme.titleSmall?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            5.width,
                            GestureDetector(
                              onTap: () {
                                context.toNamed(
                                  fullPath: loginScreen,
                                  redirect: false,
                                );
                              },
                              child: AbsorbPointer(
                                child: Text(
                                  "Login",
                                  style: context.textTheme.titleSmall?.copyWith(
                                    color: context.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        10.height,
                        SizedBox(
                          width: context.dw,
                          height: 50,
                          child: ElevatedButton(
                            style: Theme.of(context).elevatedButtonTheme.style,
                            onPressed: () {},
                            child: const Text("Sign Up"),
                          ),
                        ),
                        20.height,
                      ],
                    ),
                  ).paddingHorizontal(20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
