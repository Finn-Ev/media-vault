import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:media_vault/application/albums/controller/album_controller_bloc.dart';
import 'package:media_vault/application/assets/observer/asset_observer_bloc.dart';
import 'package:media_vault/domain/entities/media/album.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/custom_alert_dialog.dart';
import 'package:media_vault/presentation/_widgets/custom_input_alert.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../injection.dart';

class AlbumPreviewCard extends StatelessWidget {
  final Album album;

  const AlbumPreviewCard({required this.album, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetObserverBloc = sl<AssetObserverBloc>()..add(ObserveAlbumAssets(albumId: album.id.value));

    _materialPopupContent() {
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => CustomAlertDialog(
                    title: 'Delete the Album "${album.title}"?',
                    content: 'This action cannot be undone.',
                    onConfirm: () {
                      BlocProvider.of<AlbumControllerBloc>(context).add(DeleteAlbum(id: album.id));
                    },
                    confirmIsDestructive: true,
                  ),
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Cancel'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }

    _cupertinoSheetContent() {
      return CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text('Delete "${album.title}"', style: const TextStyle(color: CupertinoColors.destructiveRed)),
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (_) => CustomAlertDialog(
                  title: 'Delete the Album "${album.title}"?',
                  content: 'This action cannot be undone.',
                  onConfirm: () {
                    BlocProvider.of<AlbumControllerBloc>(context).add(DeleteAlbum(id: album.id));
                  },
                  confirmIsDestructive: true,
                ),
              );
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Edit "${album.title}"', style: const TextStyle(color: CupertinoColors.activeBlue)),
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (_) => CustomInputAlert(
                  title: 'Edit ${album.title}',
                  hintText: 'Enter the new title for the album',
                  initialInputValue: album.title,
                  onConfirm: (value) {
                    BlocProvider.of<AlbumControllerBloc>(context).add(UpdateAlbum(album: album.copyWith(title: value)));
                  },
                ),
              );
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Cancel ', style: TextStyle(color: CupertinoColors.activeBlue)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    }

    Future<String> _previewImagePath({asset}) async {
      if (asset.isVideo) {
        final thumbnail = await VideoThumbnail.thumbnailFile(
          video: asset.url,
          thumbnailPath: (await getTemporaryDirectory()).path,
          imageFormat: ImageFormat.JPEG,
          maxWidth: 300,
          maxHeight: 300,
        );

        if (thumbnail != null) {
          return thumbnail.toString();
        }
        return "";
      } else {
        return asset.url;
      }
    }

    return BlocProvider(
      create: (context) => assetObserverBloc,
      child: BlocBuilder<AssetObserverBloc, AssetObserverState>(
        builder: (context, state) {
          if (state is AssetObserverLoaded) {
            return InkResponse(
              onTap: () {
                AutoRouter.of(context).push(AssetListPageRoute(album: album));
              },
              onLongPress: () {
                showPlatformModalSheet(
                  context: context,
                  builder: (_) => PlatformWidget(
                    material: (_, __) => _materialPopupContent(),
                    cupertino: (_, __) => _cupertinoSheetContent(),
                  ),
                );
              },
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: state.assets.isEmpty
                        ? Image.network(
                            "https://songline-marketing.de/wp-content/uploads/2021/08/image-placeholder.jpg",
                            fit: BoxFit.cover,
                          )
                        : FutureBuilder<String>(
                            future: _previewImagePath(asset: state.assets.last),
                            builder: (context, snapshot) {
                              if (snapshot.hasData && state.assets.last.isVideo) {
                                return AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.asset(
                                    snapshot.data!,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              } else if (snapshot.hasData && !state.assets.last.isVideo) {
                                return AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(
                                    snapshot.data!,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return const Center(child: Text('Error'));
                              } else {
                                return const Center(child: LoadingIndicator());
                              }
                              return const Center(child: Text('Loading'));
                            }),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Text(album.title),
                      const SizedBox(
                        width: 8.0,
                        height: 8.0,
                      ),
                      Text(
                        state.assets.length.toString(),
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
