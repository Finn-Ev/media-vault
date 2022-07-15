import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/auth/auth_form/auth_form_bloc.dart';
import 'package:media_vault/core/failures/auth_failures.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';

class GoogleSignInButton extends StatelessWidget {
  GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthFormBloc, AuthFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) {
              if (failure is EmailAlreadyInUseFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('An account with this email already exists. Please login with this account instead.'),
                  ),
                );
              }
            },
            (_) {
              AutoRouter.of(context).replace(const HomePageRoute());
            },
          ),
        );
      },
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 60,
          width: 250,
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
                  style: TextStyle(color: Colors.black, fontSize: 20),
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
