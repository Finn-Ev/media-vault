import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:media_vault/application/albums/controller/album_controller_bloc.dart';
import 'package:media_vault/domain/entities/media/album.dart';
import 'package:media_vault/presentation/_widgets/custom_alert_dialog.dart';
import 'package:media_vault/presentation/_widgets/custom_input_alert.dart';

class AlbumActionSheet extends StatelessWidget {
  final Album album;

  const AlbumActionSheet({required this.album, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      material: (_, __) => BottomSheet(
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
                  showDialog(
                    context: context,
                    builder: (_) => CustomInputAlert(
                      title: 'Edit ${album.title}',
                      hintText: 'Enter the new title for the album',
                      initialInputValue: album.title,
                      onConfirm: (value) {
                        BlocProvider.of<AlbumControllerBloc>(context).add(UpdateAlbum(
                          album: album.copyWith(title: value),
                        ));
                      },
                    ),
                  );
                }),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Cancel'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      cupertino: (_, __) => CupertinoActionSheet(
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
      ),
    );
  }
}
