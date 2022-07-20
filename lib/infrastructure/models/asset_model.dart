import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:media_vault/domain/entities/auth/user_id.dart';
import 'package:media_vault/domain/entities/media/asset.dart';

class AssetModel {
  final String id;
  final String url;
  final int duration;
  final dynamic uploadedAt;
  final dynamic createdAt;

  AssetModel({
    required this.id,
    required this.url,
    required this.createdAt,
    required this.uploadedAt,
    required this.duration,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'duration': duration,
      'createdAt': createdAt,
      'uploadedAt': uploadedAt,
    };
  }

  factory AssetModel.fromMap(Map<String, dynamic> map) {
    return AssetModel(
      id: "",
      url: map['url'] as String,
      duration: map['duration'] as int,
      createdAt: map['createdAt'],
      uploadedAt: map['uploadedAt'],
    );
  }

  AssetModel copyWith({
    String? id,
    String? url,
    int? duration,
    DateTime? createdAt,
    DateTime? uploadedAt,
  }) {
    return AssetModel(
      id: id ?? this.id,
      url: url ?? this.url,
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
      id: UniqueID.fromString(id),
      url: url,
      isVideo: duration > 0,
      duration: duration,
      createdAt: createdAt,
      uploadedAt: uploadedAt,
    );
  }

  factory AssetModel.fromEntity(Asset asset) {
    return AssetModel(
      id: asset.id.toString(),
      url: asset.url,
      duration: asset.duration,
      createdAt: asset.createdAt,
      uploadedAt: asset.uploadedAt,
    );
  }
}
