import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:media_vault/domain/entities/auth/user_id.dart';
import 'package:media_vault/domain/entities/media/asset.dart';

class AssetModel {
  final String id;
  final String url;
  final bool isVideo;
  final dynamic createdAt;
  final dynamic uploadedAt;

  AssetModel({
    required this.id,
    required this.url,
    required this.isVideo,
    required this.createdAt,
    required this.uploadedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'isVideo': isVideo,
      'createdAt': createdAt,
      'uploadedAt': uploadedAt,
    };
  }

  factory AssetModel.fromMap(Map<String, dynamic> map) {
    return AssetModel(
      id: "",
      url: map['url'] as String,
      isVideo: map['isVideo'] as bool,
      createdAt: map['createdAt'],
      uploadedAt: map['uploadedAt'],
    );
  }

  AssetModel copyWith({
    String? id,
    String? url,
    bool? isVideo,
    DateTime? createdAt,
    DateTime? uploadedAt,
  }) {
    return AssetModel(
      id: id ?? this.id,
      url: url ?? this.url,
      isVideo: isVideo ?? this.isVideo,
      createdAt: createdAt ?? this.createdAt,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }

  factory AssetModel.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return AssetModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  Asset toEntity() {
    return Asset(
      id: UniqueID.fromString(id),
      url: url,
      isVideo: isVideo,
      createdAt: createdAt,
      uploadedAt: uploadedAt,
    );
  }

  factory AssetModel.fromEntity(Asset asset) {
    return AssetModel(
      id: asset.id.toString(),
      url: asset.url,
      isVideo: asset.isVideo,
      createdAt: asset.createdAt,
      uploadedAt: asset.uploadedAt,
    );
  }
}
