import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/auth/auth_core/auth_core_bloc.dart';
import 'package:media_vault/application/auth/auth_form/auth_form_bloc.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';

class GoogleSignInButton extends StatelessWidget {
  GoogleSignInButton({Key? key}) : super(key: key);

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
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 50,
          width: 225,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: InkResponse(
            onTap: () {
              BlocProvider.of<AuthFormBloc>(context).add(SignInWithGooglePressed());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 32, child: Image.asset('images/google_logo.png', fit: BoxFit.cover)),
                const Text(
                  'Sign-In with Google',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                const SizedBox(
                  width: 5.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
