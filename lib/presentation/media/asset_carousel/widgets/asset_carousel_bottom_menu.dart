import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssetCarouselBottomMenu extends StatelessWidget {
  const AssetCarouselBottomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Positioned(
        width: MediaQuery.of(context).size.width,
        bottom: 0.0,
        child: Container(
          color: themeData.scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Icon(CupertinoIcons.delete),
                ),
                Icon(CupertinoIcons.play_arrow),
                Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Icon(CupertinoIcons.share),
                ),
              ],
            ),
          ),
        ));
  }
}
