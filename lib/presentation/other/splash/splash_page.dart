import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/auth/remote_auth/remote_auth_core/remote_auth_core_bloc.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  void _showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Unfortunately, an issue occurred while trying to authenticate you. Please log in again.',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        duration: Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCoreBloc, AuthCoreState>(
      listener: (context, state) {
        if (state is AuthCoreUnauthenticated) {
          AutoRouter.of(context).replace(const LoginRoute());
        } else if (state is AuthCoreAuthenticated) {
          AutoRouter.of(context).replace(const LocalAuthRootRoute());
        }
      },

      // log out user when no AuthState was emitted after 8 seconds
      child: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: Future.delayed(const Duration(seconds: 8)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // display hint that there was an issue with the authentication and that the user should log in again
                WidgetsBinding.instance.addPostFrameCallback((_) => _showSnackbar(context));

                BlocProvider.of<AuthCoreBloc>(context).add(LogoutRequested());
                AutoRouter.of(context).replace(const LoginRoute());
              }
              return const LoadingIndicator();
            },
          ),
        ),
      ),
    );
  }
}
