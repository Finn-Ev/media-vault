import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/albums/controller/album_controller_bloc.dart';
import 'package:media_vault/domain/entities/media/album.dart';
import 'package:media_vault/presentation/_widgets/custom_alert_dialog.dart';
import 'package:media_vault/presentation/_widgets/custom_input_alert_dialog.dart';
import 'package:media_vault/presentation/_widgets/custom_modal_bottom_sheet.dart';

class AlbumActionSheet extends StatelessWidget {
  final Album album;

  const AlbumActionSheet({required this.album, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomModalBottomSheet(
      title: album.title,
      actions: [
        CustomModalBottomSheetAction(
          text: 'Rename',
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return CustomInputAlertDialog(
                  title: 'Rename album',
                  hintText: 'Enter a new name for this album',
                  onConfirm: (String newTitle) {
                    BlocProvider.of<AlbumControllerBloc>(context).add(UpdateAlbum(album: album.copyWith(title: newTitle)));
                    Navigator.of(context).pop();
                  },
                  popContextOnAction: true,
                );
              },
            );
          },
        ),
        CustomModalBottomSheetAction(
          text: "Delete",
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return CustomAlertDialog(
                  title: 'Delete',
                  content: 'Are you sure you want to delete this album?',
                  onConfirm: () {
                    BlocProvider.of<AlbumControllerBloc>(context).add(DeleteAlbum(id: album.id));
                    Navigator.pop(context);
                  },
                  confirmIsDestructive: true,
                  confirmButtonText: 'Delete',
                  popContextOnAction: true,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
