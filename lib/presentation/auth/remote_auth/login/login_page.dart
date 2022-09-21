import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/auth/local_auth/local_auth_bloc.dart';
import 'package:media_vault/application/auth/remote_auth/remote_auth_form/remote_auth_form_bloc.dart';
import 'package:media_vault/injection.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/horizontal_text_divider.dart';
import 'package:media_vault/presentation/auth/remote_auth/login/widgets/login_form.dart';
import 'package:media_vault/presentation/auth/remote_auth/login/widgets/social_sign_in_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LocalAuthBloc>(context).add(UserNavigatedToLoginPage());
    return Scaffold(
      appBar: AppBar(
        leading: const Text(""), // workaround because replace() doesn't always work as excepted
        title: const Text("Media Vault"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => sl<AuthFormBloc>(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40.0),
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
                      onTap: () => AutoRouter.of(context).push(const RegisterRoute()),
                      child: const Text("Don't have an account?", textAlign: TextAlign.center),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkResponse(
                      onTap: () => AutoRouter.of(context).push(const ForgotPasswordRoute()),
                      child: const Text("Forgot password?", textAlign: TextAlign.center),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const HorizontalTextDivider("or"),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SocialSignInButton(socialProvider: SocialProvider.apple),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SocialSignInButton(socialProvider: SocialProvider.google),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}