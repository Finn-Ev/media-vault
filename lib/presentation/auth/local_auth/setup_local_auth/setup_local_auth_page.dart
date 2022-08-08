import 'package:flutter/material.dart';

class SetupLocalAuthPage extends StatelessWidget {
  const SetupLocalAuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Vault'),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Setup local auth"),
      ),
    );
  }
}
