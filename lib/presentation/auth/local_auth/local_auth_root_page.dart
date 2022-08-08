import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/auth/auth_local/auth_local_bloc.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/loading_overlay.dart';

class LocalAuthRootPage extends StatelessWidget {
  const LocalAuthRootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AutoRouter.of(context).replace(const SetupLocalAuthRoute());
    // AutoRouter.of(context).replace(const EnterLocalAuthRoute());
    return BlocListener<AuthLocalBloc, AuthLocalState>(
      listener: (context, state) {
        // TODO: check if the user has setup local auth and redirect the user accordingly
      },
      child: const Scaffold(
        body: LoadingOverlay(),
      ),
    );
  }
}
