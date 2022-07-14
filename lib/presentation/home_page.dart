import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/auth/auth_core/auth_core_bloc.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            BlocProvider.of<AuthCoreBloc>(context).add(SignOutButtonPressed());
            AutoRouter.of(context).replace(const LoginPageRoute());
          },
        ),
        title: Text('Home Page'),
      ),
      body: Text("You are logged in"),
    );
  }
}
