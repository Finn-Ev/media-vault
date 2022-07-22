import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

Future<String> getThumbnail(String url) async {
  final thumbnail = await VideoThumbnail.thumbnailFile(
    video: url,
    thumbnailPath: (await getTemporaryDirectory()).path,
    imageFormat: ImageFormat.PNG,
  );

  if (thumbnail != null) {
    return thumbnail.toString();
  }
  return "";
}
