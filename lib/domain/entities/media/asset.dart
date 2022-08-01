import 'package:uuid/uuid.dart';

class Asset {
  final String id;
  final String albumId;
  final String url;
  final bool isVideo;
  final String thumbnailUrl;
  final int duration;
  final dynamic uploadedAt;
  final dynamic createdAt;

  Asset({
    required this.id,
    required this.albumId,
    required this.url,
    required this.isVideo,
    required this.thumbnailUrl,
    required this.duration,
    required this.uploadedAt,
    required this.createdAt,
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
      createdAt: DateTime.now(),
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
    DateTime? createdAt,
  }) {
    return Asset(
      id: id ?? this.id,
      albumId: albumId ?? this.albumId,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      duration: duration ?? this.duration,
      isVideo: isVideo ?? this.isVideo,
      createdAt: createdAt ?? this.createdAt,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}
