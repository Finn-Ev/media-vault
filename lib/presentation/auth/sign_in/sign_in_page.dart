import 'package:flutter/material.dart';
import 'package:media_vault/presentation/auth/sign_in/widgets/sign_in_form.dart';

// TODO use a switch to toggle between sign in and register
class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Media Vault"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80.0),
            const Text(
              "Login",
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
            SignInForm(),
            const SizedBox(height: 24.0),
            Row(children: <Widget>[
              Expanded(
                  child: Divider(
                color: themeData.colorScheme.onPrimary,
              )),
              const SizedBox(width: 8.0),
              Text("or"),
              const SizedBox(width: 8.0),
              Expanded(
                child: Divider(
                  color: themeData.colorScheme.onPrimary,
                ),
              ),
            ]),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Google"),
                const SizedBox(width: 8.0),
                Text("Apple"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
