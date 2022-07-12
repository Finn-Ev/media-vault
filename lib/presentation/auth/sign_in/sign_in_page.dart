import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';

// TODO use a switch to toggle between sign in and register
class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Forgot Password'),
          onPressed: () {
            AutoRouter.of(context).push(const ForgotPasswordPageRoute());
          },
        ),
      ),
    );
  }
}
