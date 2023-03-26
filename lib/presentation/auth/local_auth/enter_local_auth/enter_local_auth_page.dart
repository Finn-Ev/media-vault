import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:media_vault/application/auth/local_auth/local_auth_bloc.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/auth/local_auth/widgets/num_pad.dart';

class EnterLocalAuthPage extends StatelessWidget {
  const EnterLocalAuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onNumPadSubmit(String value) {
      BlocProvider.of<LocalAuthBloc>(context).add(LocalAuthPinWasEntered(pin: value));
    }

    return BlocListener<LocalAuthBloc, LocalAuthState>(
      listener: (context, state) {
        if (state.isAuthenticated) {
          AutoRouter.of(context).replace(const AlbumListRoute());
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
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Media Vault'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const Text(
                'Please enter your PIN',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              NumPad(onSubmit: onNumPadSubmit),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => AutoRouter.of(context).push(const ForgotPinRoute()),
                child: const Text(
                  "Forgot your PIN?",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              const Text(""),
            ],
          ),
        ),
      ),
    );
  }
}
