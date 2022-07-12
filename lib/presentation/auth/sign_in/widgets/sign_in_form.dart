import 'package:flutter/material.dart';
import 'package:media_vault/core/validators.dart';
import 'package:media_vault/presentation/_shared_widgets/custom_button.dart';

class SignInForm extends StatelessWidget {
  SignInForm({Key? key}) : super(key: key);

  String? validateEmail(String? value) {
    if (emailValidator(value) == null) {
      print("Email is valid");
      return null;
    } else {
      return emailValidator(value);
    }
  }

  String? validatePassword(String? value) {
    if (passwordValidator(value) == null) {
      print("Password is valid");
      return null;
    } else {
      return passwordValidator(value);
    }
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Email",
            ),
            validator: validateEmail,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Password",
            ),
            validator: validatePassword,
            textInputAction: TextInputAction.done,
            obscureText: true,
          ),
          const SizedBox(height: 16.0),
          CustomButton(
              text: "Login",
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  print("Form is valid");
                } else {
                  print("Form is invalid");
                }
              }),
        ],
      ),
    );
  }
}
