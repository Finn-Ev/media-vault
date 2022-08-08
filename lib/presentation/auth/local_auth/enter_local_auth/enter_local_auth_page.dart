import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/custom_button.dart';

class EnterLocalAuthPage extends StatelessWidget {
  const EnterLocalAuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Vault'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Text('Media Vault is locked'),
          const SizedBox(height: 10),
          const Text('Please enter your PIN'),
          const SizedBox(height: 10),
          CustomButton(
            onPressed: () => AutoRouter.of(context).push(const ForgotPinRoute()),
            text: "Forgot your PIN?",
          ),
          const SizedBox(height: 10),
          const Text(""),
        ],
      ),
    );
  }
}
