import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LoadingOverlay extends StatelessWidget {
  final bool onPrimary;
  const LoadingOverlay({this.onPrimary = true, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      constraints: const BoxConstraints.expand(),
      color: themeData.scaffoldBackgroundColor,
      child: Center(
        child: PlatformCircularProgressIndicator(
          material: (_, __) => MaterialProgressIndicatorData(color: onPrimary ? themeData.colorScheme.onPrimary : themeData.colorScheme.onSecondary),
          cupertino: (_, __) => CupertinoProgressIndicatorData(color: onPrimary ? themeData.colorScheme.onPrimary : themeData.colorScheme.onSecondary),
        ),
      ),
    );
  }
}
