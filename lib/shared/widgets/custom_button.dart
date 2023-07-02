import 'package:flutter/material.dart';
import 'package:media_vault/shared/widgets/loading_indicator.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isVeryDestructive;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isVeryDestructive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkResponse(
      onTap: !isLoading ? onPressed : null,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isVeryDestructive ? Colors.red[900] : themeData.colorScheme.secondary,
        ),
        child: Center(
            child: !isLoading
                ? Text(
                    text,
                    style: TextStyle(
                      color: isVeryDestructive ? Colors.white : themeData.colorScheme.onSecondary,
                      fontSize: 20,
                    ),
                  )
                : const LoadingIndicator(onPrimary: false)),
      ),
    );
  }
}
