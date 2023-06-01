import 'package:fluent/constants/color_constants.dart';
import 'package:fluent/constants/text_constants.dart';
import 'package:fluent/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../paths/image_paths.dart';
import '../model/login_model.dart';
import '../view_model/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorContants.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: context.paddingMedium,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(height: MediaQuery.of(context).size.height * 0.45, width: 200, ImagePaths.login),
                CustomTextFieldWidget(controller: _emailController, hintText: TextConstants.email),
                context.emptySizedHeightBoxLow3x,
                CustomTextFieldWidget(controller: _passwordController, hintText: TextConstants.password),
                context.emptySizedHeightBoxNormal,
                ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
                    onPressed: () async {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      if (email.isNotEmpty && email.contains("@") && password.isNotEmpty && password.length > 7) {
                        await LoginViewModel().signIn(context, LoginModel(email, password));
                      } else {
                        null;
                      }
                    },
                    child: Text(TextConstants.login, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
