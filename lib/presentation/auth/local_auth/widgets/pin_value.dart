import 'package:flutter/material.dart';

class PinValue extends StatelessWidget {
  final List<String> digits;

  const PinValue({super.key, required this.digits});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: digits
          .map((value) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: SizedBox(
                  width: 24,
                  child: Text(
                    value == "_" ? value : "*",
                    style: const TextStyle(fontSize: 42),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
