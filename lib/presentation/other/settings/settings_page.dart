import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:media_vault/application/auth/remote_auth/remote_auth_core/remote_auth_core_bloc.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/custom_alert_dialog.dart';
import 'package:media_vault/presentation/_widgets/custom_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    openLogoutAlert() {
      showPlatformDialog(
        context: context,
        builder: (_) => CustomAlertDialog(
          title: "Logout?",
          content: "Do you really want to logout of Media-Vault?",
          confirmIsDestructive: true,
          onConfirm: () {
            BlocProvider.of<AuthCoreBloc>(context).add(SignOutButtonPressed());
          },
        ),
      );
    }

    return BlocListener<AuthCoreBloc, AuthCoreState>(
      listener: (context, state) {
        if (state is AuthCoreUnauthenticated) {
          AutoRouter.of(context).replace(const LoginRoute());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Column(
          children: [
            const Text("Logged in as"),
            const SizedBox(height: 5),
            Text((BlocProvider.of<AuthCoreBloc>(context).state as AuthCoreAuthenticated).user.email),
            const SizedBox(height: 20),
            CustomButton(
              text: "Change PIN",
              onPressed: () => AutoRouter.of(context).push(const EditPinRoute()),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Logout from Media-Vault",
              onPressed: openLogoutAlert,
            )
          ],
        ),
      ),
    );
  }
}
