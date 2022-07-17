import 'package:media_vault/domain/entities/auth/user_id.dart';

class Album {
  final UniqueID id;
  final String title;
  final String sortDirection;
  final dynamic createdAt;
  final dynamic updatedAt;

  Album({
    required this.id,
    required this.title,
    required this.sortDirection,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Album.empty() {
    return Album(id: UniqueID(), title: "", sortDirection: "asc", createdAt: DateTime.now(), updatedAt: DateTime.now());
  }

  Album copyWith({
    UniqueID? id,
    String? title,
    String? sortDirection,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Album(
      id: id ?? this.id,
      title: title ?? this.title,
      sortDirection: sortDirection ?? this.sortDirection,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
