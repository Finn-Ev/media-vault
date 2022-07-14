import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/auth/auth_form/auth_form_bloc.dart';
import 'package:media_vault/injection.dart';
import 'package:media_vault/presentation/auth/forgot_password/widgets/forgot_password_form.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Media Vault"),
      ),
      body: BlocProvider(
        create: (context) => sl<AuthFormBloc>(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80.0),
              const Text(
                "Reset Password",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 12.0),
              const Text(
                "Please enter the email-address of your account.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16.0),
              ForgotPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}
