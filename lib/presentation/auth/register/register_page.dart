import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/auth/auth_form/auth_form_bloc.dart';
import 'package:media_vault/injection.dart';
import 'package:media_vault/presentation/auth/register/widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
                "Register",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 12.0),
              const Text(
                "Create your personal account",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16.0),
              RegisterForm(),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkResponse(
                    onTap: () => AutoRouter.of(context).pop(),
                    child: const Text("Already have an account?"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
