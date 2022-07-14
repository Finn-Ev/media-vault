import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/auth/auth_core/auth_core_bloc.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCoreBloc, AuthCoreState>(
      listener: (context, state) {
        if (state is AuthCoreUnauthenticated) {
          AutoRouter.of(context).replace(const LoginPageRoute());
        } else if (state is AuthStateAuthenticated) {
          AutoRouter.of(context).replace(const HomePageRoute());
        }
      },
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
