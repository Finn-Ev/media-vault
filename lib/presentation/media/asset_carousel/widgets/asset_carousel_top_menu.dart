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
        return Positioned(
          width: MediaQuery.of(context).size.width,
          top: 0.0,
          child: Container(
            color: themeData.scaffoldBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.close,
                    color: themeData.scaffoldBackgroundColor,
                    size: 28, // invisible, but needed to exactly center the counter
                  ),
                  Text('${state.carouselIndex}/${state.carouselItemCount}', style: TextStyle(fontSize: 16.0)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
