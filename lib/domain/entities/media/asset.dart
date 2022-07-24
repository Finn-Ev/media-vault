import 'package:uuid/uuid.dart';

class Asset {
  final String id;
  final String url;
  final bool isVideo;
  final int duration;
  final dynamic createdAt;
  final dynamic uploadedAt;

  Asset({
    required this.id,
    required this.url,
    required this.isVideo,
    required this.duration,
    required this.createdAt,
    required this.uploadedAt,
  });

  factory Asset.empty() {
    return Asset(id: const Uuid().v4(), url: "", isVideo: false, duration: 0, createdAt: DateTime.now(), uploadedAt: DateTime.now());
  }

  Asset copyWith({
    String? id,
    String? url,
    bool? isVideo,
    int? duration,
    DateTime? createdAt,
    DateTime? uploadedAt,
  }) {
    return Asset(
      id: id ?? this.id,
      url: url ?? this.url,
      isVideo: this.isVideo,
      duration: duration ?? this.duration,
      createdAt: createdAt ?? this.createdAt,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}
