import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/features/auth/application/remote_auth/remote_auth_core/remote_auth_core_bloc.dart';
import 'package:media_vault/routes/routes.gr.dart';
import 'package:media_vault/shared/widgets/loading_indicator.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with WidgetsBindingObserver {
  bool _isInForeground = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Any setState() call inside the didChangeAppLifecycleState-method seems to do the trick.
    // So it would work just as well without changing the _isInForeground variable (but keeping the setState() call with a empty body).
    // However, this seems to be a kind of buggy and not really intended, so I'm using the variable to be safe in case the behavior changes in the future.
    setState(() {
      _isInForeground = state == AppLifecycleState.resumed;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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
    if (!_isInForeground) {
      return Container();
    }

    return BlocListener<AuthCoreBloc, AuthCoreState>(
      listener: (context, state) {
        if (state is AuthCoreUnauthenticated) {
          AutoRouter.of(context).replace(const LoginRoute());
        } else if (state is AuthCoreAuthenticated) {
          if (!state.user.emailVerified) {
            AutoRouter.of(context).replace(const LoginRoute());
          } else {
            AutoRouter.of(context).replace(const LocalAuthRootRoute());
          }
        }
      },

      // log out user when no AuthState was emitted after 8 seconds
      child: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: Future.delayed(const Duration(seconds: 8)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // display a hint that there was an issue with the authentication and that the user should log in again
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
