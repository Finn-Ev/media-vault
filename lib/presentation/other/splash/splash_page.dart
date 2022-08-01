import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/auth/auth_core/auth_core_bloc.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCoreBloc, AuthCoreState>(
      listener: (context, state) {
        if (state is AuthCoreUnauthenticated) {
          AutoRouter.of(context).replace(const LoginRoute());
        } else if (state is AuthCoreAuthenticated) {
          AutoRouter.of(context).replace(const AlbumListRoute());
        }
      },
      child: const Scaffold(
        body: Center(
          child: LoadingIndicator(),
        ),
      ),
    );
  }
}
