import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:media_vault/features/auth/presentation/local_auth/widgets/num_pad.dart';
import 'package:media_vault/routes/routes.gr.dart';

@RoutePage()
class LocalAuthSetupPage extends StatelessWidget {
  const LocalAuthSetupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    goToConfirmPage(String pin) {
      AutoRouter.of(context).push(ConfirmLocalAuthSetupRoute(pin: pin));
    }

    return Scaffold(
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
              const Expanded(child: Text("Please enter a PIN")),
              NumPad(onSubmit: goToConfirmPage),
            ],
          ),
        ),
      ),
    );
  }
}
