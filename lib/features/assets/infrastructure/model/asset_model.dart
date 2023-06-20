import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:media_vault/features/assets/domain/entities/asset.dart';

class AssetModel {
  final String id;
  final String albumId;
  final String url;
  final String thumbnailUrl;
  final int duration;
  final dynamic uploadedAt;
  final dynamic modifiedAt;

  AssetModel({
    required this.id,
    required this.albumId,
    required this.url,
    required this.thumbnailUrl,
    required this.modifiedAt,
    required this.duration,
    required this.uploadedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'albumId': albumId,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
      'duration': duration,
      'modifiedAt': modifiedAt,
      'uploadedAt': uploadedAt,
    };
  }

  factory AssetModel.fromMap(Map<String, dynamic> map) {
    final modifiedAt = DateTime.fromMillisecondsSinceEpoch(map['modifiedAt'].seconds * 1000);
    final uploadedAt = DateTime.fromMillisecondsSinceEpoch(map['uploadedAt'].seconds * 1000);
    return AssetModel(
      id: "",
      albumId: map['albumId'] as String,
      url: map['url'] as String,
      thumbnailUrl: map['thumbnailUrl'] as String,
      duration: map['duration'] as int,
      modifiedAt: modifiedAt,
      uploadedAt: uploadedAt,
    );
  }

  AssetModel copyWith({
    String? id,
    String? albumId,
    String? url,
    String? thumbnailUrl,
    int? duration,
    DateTime? modifiedAt,
    DateTime? uploadedAt,
  }) {
    return AssetModel(
      id: id ?? this.id,
      albumId: albumId ?? this.albumId,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      duration: duration ?? this.duration,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }

  factory AssetModel.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return AssetModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  Asset toEntity() {
    return Asset(
      id: id,
      albumId: albumId,
      url: url,
      thumbnailUrl: thumbnailUrl,
      isVideo: duration > 0,
      duration: duration,
      modifiedAt: modifiedAt,
      uploadedAt: uploadedAt,
    );
  }

  factory AssetModel.fromEntity(Asset asset) {
    return AssetModel(
      id: asset.id,
      albumId: asset.albumId,
      url: asset.url,
      thumbnailUrl: asset.thumbnailUrl,
      duration: asset.duration,
      modifiedAt: asset.modifiedAt,
      uploadedAt: asset.uploadedAt,
    );
  }
}
