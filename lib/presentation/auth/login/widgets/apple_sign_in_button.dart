import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/auth/auth_form/auth_form_bloc.dart';

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 225,
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
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            const SizedBox(
              width: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}
