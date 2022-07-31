import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:media_vault/domain/entities/media/album.dart';

class AlbumModel {
  final String id;
  final String title;
  final dynamic createdAt;
  final dynamic updatedAt;

  AlbumModel({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory AlbumModel.fromMap(Map<String, dynamic> map) {
    return AlbumModel(
      id: "",
      title: map['title'] as String,
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  AlbumModel copyWith({
    String? id,
    String? title,
    dynamic createdAt,
    dynamic updatedAt,
  }) {
    return AlbumModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
      updatedAt: updatedAt,
    );
  }

  factory AlbumModel.fromEntity(Album album) {
    return AlbumModel(
      id: album.id.toString(),
      title: album.title,
      createdAt: album.createdAt,
      updatedAt: album.updatedAt,
    );
  }
}
