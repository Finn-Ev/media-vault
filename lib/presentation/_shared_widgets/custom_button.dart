import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkResponse(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: themeData.colorScheme.secondary,
        ),
        child: Center(
          child: Text(
            'Sign In',
            style: TextStyle(
              color: themeData.colorScheme.onSecondary,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
