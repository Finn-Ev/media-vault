import 'package:flutter/material.dart';

// TODO use a switch to toggle between sign in and register
class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: const Center(child: Text('Hello World')),
    );
  }
}
