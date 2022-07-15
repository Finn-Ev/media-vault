import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return PlatformCircularProgressIndicator(
      material: (_, __) => MaterialProgressIndicatorData(color: themeData.colorScheme.onSecondary),
      cupertino: (_, __) => CupertinoProgressIndicatorData(color: themeData.colorScheme.onSecondary),
    );
  }
}
