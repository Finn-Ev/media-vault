import 'package:flutter/material.dart';

class HorizontalTextDivider extends StatelessWidget {
  final String text;
  const HorizontalTextDivider(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Row(children: <Widget>[
      Expanded(
          child: Divider(
        color: themeData.colorScheme.onPrimary,
      )),
      const SizedBox(width: 8.0),
      Text(text),
      const SizedBox(width: 8.0),
      Expanded(
        child: Divider(
          color: themeData.colorScheme.onPrimary,
        ),
      ),
    ]);
  }
}
