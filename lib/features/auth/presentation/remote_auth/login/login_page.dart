import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/constants.dart';
import 'package:media_vault/features/auth/application/local_auth/local_auth_bloc.dart';
import 'package:media_vault/features/auth/application/remote_auth/remote_auth_form/remote_auth_form_bloc.dart';
import 'package:media_vault/features/auth/presentation/remote_auth/login/widgets/login_form.dart';
import 'package:media_vault/features/auth/presentation/remote_auth/login/widgets/social_sign_in_button.dart';
import 'package:media_vault/injection.dart';
import 'package:media_vault/routes/routes.gr.dart';
import 'package:media_vault/shared/widgets/horizontal_text_divider.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LocalAuthBloc>(context).add(UserNavigatedToLoginPage());
    return Scaffold(
      appBar: AppBar(
        // workaround because replace() doesn't always work as excepted and thus the back button is shown
        leading: const Text(""),
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
                  "Welcome",
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
                if (kEnableSocialSignIn)
                  const Column(
                    children: [
                      SizedBox(height: 24),
                      HorizontalTextDivider("or"),
                      SizedBox(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialSignInButton(socialProvider: SocialProvider.apple),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialSignInButton(socialProvider: SocialProvider.google),
                        ],
                      ),
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
