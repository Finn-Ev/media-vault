import 'package:uuid/uuid.dart';

class Album {
  final String id;
  final String title;
  final dynamic createdAt;
  final dynamic updatedAt;

  Album({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Album.empty() {
    return Album(id: const Uuid().v4(), title: "", createdAt: DateTime.now(), updatedAt: DateTime.now());
  }

  Album copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Album(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
