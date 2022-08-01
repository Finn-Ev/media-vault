import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';

class TrashAppBarIcon extends StatelessWidget {
  const TrashAppBarIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          IconButton(
              onPressed: () {
                AutoRouter.of(context).push(const TrashRoute());
              },
              icon: Icon(CupertinoIcons.trash)),
          const Positioned(top: 0, right: 3, child: Text('3')),
        ],
      ),
    );
  }
}
