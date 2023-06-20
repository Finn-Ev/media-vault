import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:media_vault/features/albums/domain/entities/album.dart';

class AlbumModel {
  final String id;
  final String title;
  final dynamic createdAt;
  final bool deleted;

  AlbumModel({
    required this.id,
    required this.title,
    required this.createdAt,
    this.deleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt,
      'deleted': deleted,
    };
  }

  factory AlbumModel.fromMap(Map<String, dynamic> map) {
    final createdAt = DateTime.fromMillisecondsSinceEpoch(map['createdAt'].seconds * 1000);
    return AlbumModel(
      id: "",
      title: map['title'] as String,
      createdAt: createdAt,
      deleted: map['deleted'] as bool,
    );
  }

  AlbumModel copyWith({
    String? id,
    String? title,
    dynamic createdAt,
    dynamic updatedAt,
    bool? deleted,
  }) {
    return AlbumModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      deleted: deleted ?? this.deleted,
    );
  }

  factory AlbumModel.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return AlbumModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  Album toEntity() {
    return Album(
      id: id,
      title: title,
      createdAt: createdAt,
      deleted: deleted,
    );
  }

  factory AlbumModel.fromEntity(Album album) {
    return AlbumModel(
      id: album.id.toString(),
      title: album.title,
      createdAt: album.createdAt,
      deleted: album.deleted,
    );
  }
}
