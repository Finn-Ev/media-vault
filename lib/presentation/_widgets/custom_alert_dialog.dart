import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function onConfirm;
  final bool confirmIsDestructive;

  const CustomAlertDialog({
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.confirmIsDestructive,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        PlatformDialogAction(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        PlatformDialogAction(
          child: const Text('Confirm'),
          cupertino: (_, __) => CupertinoDialogActionData(
            isDefaultAction: !confirmIsDestructive,
            isDestructiveAction: confirmIsDestructive,
            child: const Text('Confirm'),
          ),
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
