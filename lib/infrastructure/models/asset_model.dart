import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:media_vault/domain/entities/media/asset.dart';

class AssetModel {
  final String id;
  final String url;
  final String thumbnailUrl;
  final int duration;
  final dynamic uploadedAt;
  final dynamic createdAt;

  AssetModel({
    required this.id,
    required this.url,
    required this.thumbnailUrl,
    required this.createdAt,
    required this.duration,
    required this.uploadedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
      'duration': duration,
      'createdAt': createdAt,
      'uploadedAt': uploadedAt,
    };
  }

  factory AssetModel.fromMap(Map<String, dynamic> map) {
    return AssetModel(
      id: "",
      url: map['url'] as String,
      thumbnailUrl: map['thumbnailUrl'] as String,
      duration: map['duration'] as int,
      createdAt: map['createdAt'],
      uploadedAt: map['uploadedAt'],
    );
  }

  AssetModel copyWith({
    String? id,
    String? url,
    String? thumbnailUrl,
    int? duration,
    DateTime? createdAt,
    DateTime? uploadedAt,
  }) {
    return AssetModel(
      id: id ?? this.id,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      duration: duration ?? this.duration,
      createdAt: createdAt ?? this.createdAt,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }

  factory AssetModel.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return AssetModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  Asset toEntity() {
    return Asset(
      id: id,
      url: url,
      thumbnailUrl: thumbnailUrl,
      isVideo: duration > 0,
      duration: duration,
      createdAt: createdAt,
      uploadedAt: uploadedAt,
    );
  }

  factory AssetModel.fromEntity(Asset asset) {
    return AssetModel(
      id: asset.id,
      url: asset.url,
      thumbnailUrl: asset.thumbnailUrl,
      duration: asset.duration,
      createdAt: asset.createdAt,
      uploadedAt: asset.uploadedAt,
    );
  }
}
