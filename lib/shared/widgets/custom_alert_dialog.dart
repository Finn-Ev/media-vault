import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function onConfirm;
  final String confirmButtonText;
  final bool confirmIsDestructive;
  final String cancelButtonText;
  final Function? onCancel;
  // sometimes it is necessary to run a extra pop() out of this widget's context to close all popups and dialogs correctly
  final bool popContextOnAction;

  const CustomAlertDialog({
    required this.title,
    required this.content,
    required this.onConfirm,
    this.confirmButtonText = "Confirm",
    this.confirmIsDestructive = false,
    this.cancelButtonText = "Cancel",
    this.onCancel,
    this.popContextOnAction = false,
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
            if (onCancel != null) {
              onCancel!();
            } else {
              Navigator.of(context).pop();
            }
            if (popContextOnAction) Navigator.of(context).pop();
          },
        ),
        PlatformDialogAction(
          child: const Text('Confirm'),
          cupertino: (_, __) => CupertinoDialogActionData(
            isDefaultAction: !confirmIsDestructive,
            isDestructiveAction: confirmIsDestructive,
            child: Text(confirmButtonText),
          ),
          onPressed: () {
            onConfirm();
            if (popContextOnAction) Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
