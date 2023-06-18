import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/asset_carousel/asset_carousel_bloc.dart';

class AssetCarouselTopMenu extends StatelessWidget {
  const AssetCarouselTopMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<AssetCarouselBloc, AssetCarouselState>(
      builder: (context, state) {
        return state.showMenuUI
            ? Positioned(
                width: MediaQuery.of(context).size.width,
                top: 0.0,
                child: Container(
                  color: themeData.scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Platform.isIOS
                              ? const Icon(
                                  CupertinoIcons.back,
                                  size: 30,
                                )
                              : const Icon(
                                  Icons.arrow_back,
                                  size: 30,
                                ),
                        ),
                        Text('${state.carouselIndex + 1}/${state.carouselItemCount}',
                            style: const TextStyle(fontSize: 16.0)),
                        Icon(
                          CupertinoIcons.back,
                          color: themeData.scaffoldBackgroundColor,
                          size: 30, // invisible, but needed to exactly center the counter
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container();
      },
    );
  }
}
