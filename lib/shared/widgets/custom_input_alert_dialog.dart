import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class CustomInputAlertDialog extends StatelessWidget {
  final String title;
  final String hintText;
  final String initialInputValue;
  final String confirmText;
  final Function(String) onConfirm;
  // sometimes it is necessary to run a extra pop() out of this widget's context to close all popups and dialogs correctly
  final bool popContextOnAction;

  const CustomInputAlertDialog({
    required this.title,
    required this.hintText,
    required this.onConfirm,
    this.initialInputValue = '',
    this.confirmText = 'Confirm',
    this.popContextOnAction = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: initialInputValue);
    controller.text = initialInputValue;
    final themeData = Theme.of(context);
    return PlatformAlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(hintText),
          const SizedBox(height: 8),
          PlatformTextField(
            style: TextStyle(
              color: themeData.colorScheme.onPrimary,
            ),
            onChanged: (value) {},
            controller: controller,
          ),
        ],
      ),
      actions: [
        PlatformDialogAction(
          child: const Text('Cancel'),
          cupertino: (_, __) => CupertinoDialogActionData(
            isDestructiveAction: true,
            child: const Text('Cancel'),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        PlatformDialogAction(
          child: Text(confirmText),
          cupertino: (_, __) => CupertinoDialogActionData(
            isDefaultAction: true,
            child: Text(confirmText),
          ),
          onPressed: () {
            if (controller.text.isNotEmpty) {
              onConfirm(controller.text);
              if (popContextOnAction) Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
