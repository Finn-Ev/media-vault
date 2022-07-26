import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

Future<String> getThumbnail(Asset asset) async {
  final cachedThumbnail = await DefaultCacheManager().getFileFromCache(asset.id);

  // check if cached thumbnail exists
  if (cachedThumbnail != null) {
    if (cachedThumbnail.validTill.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch > 0) {
      // check if the cached file is still valid
      return cachedThumbnail.originalUrl;
    } else {
      // other wise remove it from cache
      DefaultCacheManager().removeFile(asset.id);
    }
  }
  print("getting thumbnail");
  final thumbnail = await VideoThumbnail.thumbnailFile(
    video: asset.url,
    thumbnailPath: (await getTemporaryDirectory()).path,
    imageFormat: ImageFormat.PNG,
  );

  if (thumbnail != null) {
    // DefaultCacheManager().removeFile(url);
    await DefaultCacheManager().putFile(thumbnail, File(thumbnail).readAsBytesSync(), key: asset.id, maxAge: const Duration(hours: 1));
    return thumbnail.toString();
  }
  return "";
}
