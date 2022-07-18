import 'package:media_vault/domain/entities/auth/user_id.dart';

class Asset {
  final UniqueID id;
  final String url;
  final bool isVideo;
  final dynamic createdAt;
  final dynamic uploadedAt;

  Asset({
    required this.id,
    required this.url,
    required this.isVideo,
    required this.createdAt,
    required this.uploadedAt,
  });

  factory Asset.empty() {
    return Asset(id: UniqueID(), url: "", isVideo: false, createdAt: DateTime.now(), uploadedAt: DateTime.now());
  }

  Asset copyWith({
    UniqueID? id,
    String? url,
    bool? isVideo,
    DateTime? createdAt,
    DateTime? uploadedAt,
  }) {
    return Asset(
      id: id ?? this.id,
      url: url ?? this.url,
      isVideo: isVideo ?? this.isVideo,
      createdAt: createdAt ?? this.createdAt,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}
