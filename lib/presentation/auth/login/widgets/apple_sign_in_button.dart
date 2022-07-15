import 'dart:io' show Platform;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/auth/auth_form/auth_form_bloc.dart';
import 'package:media_vault/core/failures/auth_failures.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return BlocListener<AuthFormBloc, AuthFormState>(
        listener: (context, state) {
          state.authFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) {
                if (failure is EmailAlreadyInUseFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
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
        child: Container(
          height: 65,
          width: 250,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white),
            color: Colors.black,
          ),
          child: InkResponse(
            onTap: () => BlocProvider.of<AuthFormBloc>(context).add(SignInWithApplePressed()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 24, child: Image.asset('images/apple_logo.png', fit: BoxFit.cover)),
                const SizedBox(
                  width: 7.0,
                ),
                const Text(
                  'Sign-In with Apple',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(
                  width: 5.0,
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
