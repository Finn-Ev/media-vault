import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:media_vault/application/auth/local_auth/local_auth_bloc.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/auth/local_auth/widgets/num_pad.dart';

class ConfirmLocalAuthSetupPage extends StatelessWidget {
  final String pin;

  const ConfirmLocalAuthSetupPage({required this.pin, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onNumPadSubmit(confirmationPin) {
      if (confirmationPin == pin) {
        BlocProvider.of<LocalAuthBloc>(context).add(LocalAuthSetupPinsMatch(pin: pin));
      } else {
        showPlatformDialog(
            context: context,
            builder: (_) {
              return PlatformAlertDialog(
                title: const Text('PINs do not match'),
                content: const Text('Please try again'),
                actions: <Widget>[
                  PlatformDialogAction(
                    child: const Text('OK'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              );
            });
      }
    }

    return BlocListener<LocalAuthBloc, LocalAuthState>(
      listener: (context, state) {
        if (state.isAuthenticated && state.hasBeenSetup) {
          showPlatformDialog(
              context: context,
              builder: (_) {
                return PlatformAlertDialog(
                  title: const Text('PIN was set successfully!'),
                  actions: <Widget>[
                    PlatformDialogAction(
                      child: const Text('OK'),
                      onPressed: () => AutoRouter.of(context).replace(const AlbumListRoute()),
                    )
                  ],
                );
              });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Media Vault'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(child: Text("Please confirm the PIN")),
                NumPad(onSubmit: onNumPadSubmit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
