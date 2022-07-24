import 'package:flutter/widgets.dart';
import 'package:media_vault/domain/entities/auth/user_id.dart';
import 'package:media_vault/domain/entities/media/asset.dart';

class MoveAssetsPage extends StatelessWidget {
  final UniqueID sourceAlbumId;
  final List<Asset> assetsToMove;
  final bool copy;

  const MoveAssetsPage({
    required this.sourceAlbumId,
    required this.assetsToMove,
    required this.copy,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // todo display all albums except source album
    return Container();
  }
}
