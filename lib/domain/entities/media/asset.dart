import 'package:uuid/uuid.dart';

class Asset {
  final String id;
  final String albumId;
  final String url;
  final bool isVideo;
  final String thumbnailUrl;
  final int duration;
  final DateTime uploadedAt;
  final DateTime modifiedAt;

  Asset({
    required this.id,
    required this.albumId,
    required this.uploadedAt,
    required this.modifiedAt,
    this.url = "",
    this.duration = 0,
    this.isVideo = false,
    this.thumbnailUrl = "",
  });

  factory Asset.empty() {
    return Asset(
      id: const Uuid().v4(),
      albumId: "",
      url: "",
      isVideo: false,
      thumbnailUrl: "",
      duration: 0,
      uploadedAt: DateTime.now(),
      modifiedAt: DateTime.now(),
    );
  }

  Asset copyWith({
    String? id,
    String? albumId,
    String? url,
    bool? isVideo,
    String? thumbnailUrl,
    int? duration,
    DateTime? uploadedAt,
    DateTime? modifiedAt,
  }) {
    return Asset(
      id: id ?? this.id,
      albumId: albumId ?? this.albumId,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      duration: duration ?? this.duration,
      isVideo: isVideo ?? this.isVideo,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}
