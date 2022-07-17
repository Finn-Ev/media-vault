import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class CustomInputAlert extends StatelessWidget {
  final String title;
  final String hintText;
  final String initialInputValue;
  final String confirmText;
  final Function(String) onConfirm;

  final TextEditingController _controller = TextEditingController();

  CustomInputAlert({
    required this.title,
    required this.hintText,
    required this.onConfirm,
    this.initialInputValue = '',
    this.confirmText = 'Confirm',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.text = initialInputValue;
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
            controller: _controller,
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        PlatformDialogAction(
          child: const Text('Create'),
          cupertino: (_, __) => CupertinoDialogActionData(
            isDefaultAction: true,
            child: Text(confirmText),
          ),
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              onConfirm(_controller.text);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
