import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/features/assets/application/asset_carousel/asset_carousel_bloc.dart';

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
                        IconButton(
                          splashRadius: 16,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Platform.isIOS
                              ? const Icon(
                                  CupertinoIcons.back,
                                  size: 32,
                                )
                              : const Icon(
                                  Icons.arrow_back,
                                  size: 32,
                                ),
                        ),
                        Text('${state.carouselIndex + 1}/${state.carouselItemCount}',
                            style: const TextStyle(fontSize: 16.0)),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.back,
                            size: 32,
                            color: themeData.scaffoldBackgroundColor,
                          ),
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
