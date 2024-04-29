import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_pos/_application/application.dart';
import 'package:mini_pos/auth/auth.dart';
import 'package:mini_pos/ui/ui.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => LoginProvider(),
        child: SingleChildScrollView(
          child: Consumer<LoginProvider>(
            builder: (context, value, child) {
              return Form(
                key: value.formKey,
                child: Column(
                  children: [
                    LottieBuilder.asset(login),
                    CusTextField(
                      validator: value.validator,
                      textEditingController: value.usernameController,
                      label: "Username",
                      hintText: "Enter Username",
                    ),
                    20.height,
                    CusTextField(
                      validator: value.validator,
                      textEditingController: value.passwordController,
                      isSecret: true,
                      label: "Password",
                      hintText: "Enter Password",
                    ),
                    50.height,
                    Row(
                      children: [
                        Text(
                          "Don't have an account?",
                          style: context.textTheme.titleSmall?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        5.width,
                        GestureDetector(
                          onTap: () {
                            context.toNamed(
                              fullPath: signUpScreen,
                              redirect: false,
                            );
                          },
                          child: AbsorbPointer(
                            child: Text(
                              "Sign Up",
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
                        onPressed: () {
                          value.login(context);
                        },
                        child: const Text("Login"),
                      ),
                    )
                  ],
                ).paddingAll(20),
              );
            },
          ),
        ),
      ),
    );
  }
}
