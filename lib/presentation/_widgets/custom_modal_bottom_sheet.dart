import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class CustomModalBottomSheetAction {
  final String text;
  final Function onPressed;

  const CustomModalBottomSheetAction({
    required this.text,
    required this.onPressed,
  });
}

class CustomModalBottomSheet extends StatelessWidget {
  final List<CustomModalBottomSheetAction> actions;
  const CustomModalBottomSheet({required this.actions, Key? key}) : super(key: key);

  static void open({required context, required List<CustomModalBottomSheetAction> actions}) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(context: context, builder: (_) => _getIOSContent(context, actions));
    } else {
      showModalBottomSheet(context: context, builder: (_) => _getMaterialContent(context, actions));
    }
  }

  static _getMaterialContent(context, List<CustomModalBottomSheetAction> actions) {
    return BottomSheet(
      onClosing: () {},
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...actions.map((action) {
            return ListTile(
              title: Text(action.text),
              onTap: () {
                action.onPressed();
              },
            );
          }).toList(),
          ListTile(
            title: const Text('Cancel'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  static _getIOSContent(BuildContext context, List<CustomModalBottomSheetAction> actions) {
    return CupertinoActionSheet(
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Cancel', style: TextStyle(color: CupertinoColors.destructiveRed, fontWeight: FontWeight.normal)),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        ...actions.map((action) {
          return CupertinoActionSheetAction(
            child: Text(
              action.text,
              style: const TextStyle(color: CupertinoColors.activeBlue, fontWeight: FontWeight.normal),
            ),
            onPressed: () {
              action.onPressed();
            },
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      material: (_, __) {
        return _getMaterialContent(context, actions);
      },
      cupertino: (_, __) {
        return _getIOSContent(context, actions);
      },
    );
  }
}
