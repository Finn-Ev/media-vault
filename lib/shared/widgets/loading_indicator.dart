import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LoadingIndicator extends StatelessWidget {
  final bool onPrimary;
  const LoadingIndicator({this.onPrimary = true, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return PlatformCircularProgressIndicator(
      material: (_, __) => MaterialProgressIndicatorData(color: onPrimary ? themeData.colorScheme.onPrimary : themeData.colorScheme.onSecondary),
      cupertino: (_, __) => CupertinoProgressIndicatorData(color: onPrimary ? themeData.colorScheme.onPrimary : themeData.colorScheme.onSecondary),
    );
  }
}
