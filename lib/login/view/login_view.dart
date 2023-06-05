import 'package:fluent/constants/text_constants.dart';
import 'package:fluent/login/model/login_model.dart';
import 'package:fluent/login/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../constants/color_constants.dart';
import '../../paths/image_paths.dart';

part 'email_text_from_field.dart';
part 'password_text_from_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorContants.backgroundColor,
      body: Padding(
        padding: context.paddingLow,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(height: MediaQuery.of(context).size.height * 0.45, width: 200, ImagePaths.login),
              Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      emailTextFromField(_emailController),
                      context.emptySizedHeightBoxLow3x,
                      passwordTextFromField(_passwordController),
                      context.emptySizedHeightBoxLow3x,
                      ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              LoginViewModel().signIn(context, LoginModel(_emailController.text, _passwordController.text));
                            } else {
                              null;
                            }
                          },
                          child: Text(TextConstants.login,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              )))
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
