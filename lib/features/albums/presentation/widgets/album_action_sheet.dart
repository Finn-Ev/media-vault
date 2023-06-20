import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/features/albums/application/controller/album_controller_bloc.dart';
import 'package:media_vault/features/albums/domain/entities/album.dart';
import 'package:media_vault/shared/widgets/custom_alert_dialog.dart';
import 'package:media_vault/shared/widgets/custom_input_alert_dialog.dart';
import 'package:media_vault/shared/widgets/custom_modal_bottom_sheet.dart';

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
                    BlocProvider.of<AlbumControllerBloc>(context)
                        .add(UpdateAlbum(album: album.copyWith(title: newTitle)));
                    Navigator.of(context).pop();
                  },
                  initialInputValue: album.title,
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
                  title: 'Delete album?',
                  content: 'It will be moved to trash',
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
