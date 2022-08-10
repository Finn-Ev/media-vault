import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:media_vault/application/auth/local_auth/local_auth_bloc.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/auth/local_auth/widgets/num_pad.dart';

class EditPinPage extends StatelessWidget {
  const EditPinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onNumPadSubmit(String pin) {
      BlocProvider.of<LocalAuthBloc>(context).add(LocalAuthPinWasEntered(pin: pin));
    }

    return BlocListener<LocalAuthBloc, LocalAuthState>(
      listener: (context, state) {
        if (state.incorrectPinFailure == false) {
          AutoRouter.of(context).push(const LocalAuthSetupRoute());
        } else if (state.incorrectPinFailure == true) {
          showPlatformDialog(
            context: context,
            builder: (_) {
              return PlatformAlertDialog(
                title: const Text('PIN is incorrect'),
                content: const Text('Please try again'),
                actions: <Widget>[
                  PlatformDialogAction(
                    child: const Text('OK'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              );
            },
          );
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
                const Expanded(child: Text("Please enter your current PIN")),
                NumPad(onSubmit: onNumPadSubmit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
