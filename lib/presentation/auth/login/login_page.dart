import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/auth/auth_form/auth_form_bloc.dart';
import 'package:media_vault/injection.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/horizontal_text_divider.dart';
import 'package:media_vault/presentation/auth/login/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                "Login",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 12.0),
              const Text(
                "Please login to your account",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16.0),
              LoginForm(),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkResponse(
                    onTap: () => AutoRouter.of(context).push(const RegisterPageRoute()),
                    child: const Text("Don't have an account?", textAlign: TextAlign.center),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const HorizontalTextDivider("or"),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Google"),
                  SizedBox(width: 8.0),
                  Text("Apple"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
