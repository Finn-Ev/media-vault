import 'package:flutter/material.dart';
import 'package:media_vault/domain/entities/media/asset.dart';

class AssetPreviewCard extends StatelessWidget {
  final Asset asset;

  const AssetPreviewCard({required this.asset, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      // padding: const EdgeInsets.all(8.0),

      child: Image.network(asset.url, fit: BoxFit.cover),
    );
  }
}
