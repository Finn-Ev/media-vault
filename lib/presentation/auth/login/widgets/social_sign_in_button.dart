import 'dart:io' show Platform;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/auth/auth_form/auth_form_bloc.dart';
import 'package:media_vault/core/failures/auth_failures.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';

enum SocialProvider {
  google,
  apple,
}

class SocialSignInButton extends StatelessWidget {
  final SocialProvider socialProvider;

  const SocialSignInButton({required this.socialProvider, Key? key}) : super(key: key);

  _buildSocialIcon() {
    if (socialProvider == SocialProvider.google) {
      return SizedBox(height: 32, child: Image.asset('images/google_logo.png', fit: BoxFit.cover));
    } else if (socialProvider == SocialProvider.apple) {
      return SizedBox(height: 24, child: Image.asset('images/apple_logo.png', fit: BoxFit.cover));
    }
  }

  _buildButtonText() {
    if (socialProvider == SocialProvider.apple) {
      return const Text(
        'Sign-In with Apple',
        style: TextStyle(color: Colors.white, fontSize: 20),
      );
    } else if (socialProvider == SocialProvider.google) {
      return const Text(
        'Sign-In with Google',
        style: TextStyle(color: Colors.black, fontSize: 20),
      );
    }
  }

  /// hide the button if the platform is not iOS but the provider is apple
  bool _shouldBeDisplayed() {
    if (socialProvider == SocialProvider.apple) {
      return Platform.isIOS;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_shouldBeDisplayed()) {
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
                AutoRouter.of(context).replace(const AlbumListRoute());
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
            color: socialProvider == SocialProvider.apple ? Colors.black : Colors.white,
          ),
          child: InkResponse(
            onTap: () => socialProvider == SocialProvider.apple
                ? BlocProvider.of<AuthFormBloc>(context).add(SignInWithApplePressed())
                : BlocProvider.of<AuthFormBloc>(context).add(SignInWithGooglePressed()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildSocialIcon(),
                if (socialProvider == SocialProvider.apple)
                  const SizedBox(
                    width: 7.0,
                  ),
                _buildButtonText(),
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
