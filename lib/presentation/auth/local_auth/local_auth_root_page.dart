import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/auth/local_auth/local_auth_bloc.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/loading_overlay.dart';

class LocalAuthRootPage extends StatelessWidget {
  const LocalAuthRootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LocalAuthBloc>(context).add(LocalAuthSetupCheckRequest());
    return BlocListener<LocalAuthBloc, LocalAuthState>(
      listener: (context, state) {
        if (state.isSetup) {
          AutoRouter.of(context).replace(const EnterLocalAuthRoute());
        } else {
          AutoRouter.of(context).replace(const LocalAuthSetupRoute());
        }
      },
      child: const Scaffold(
        body: LoadingOverlay(),
      ),
    );
  }
}
