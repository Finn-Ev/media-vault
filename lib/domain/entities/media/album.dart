import 'package:uuid/uuid.dart';

class Album {
  final String id;
  final String title;
  final DateTime createdAt;
  final bool deleted;

  Album({
    required this.id,
    required this.title,
    required this.createdAt,
    this.deleted = false,
  });

  factory Album.empty() {
    return Album(id: const Uuid().v4(), title: "", createdAt: DateTime.now(), deleted: false);
  }

  Album copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? deleted,
  }) {
    return Album(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      deleted: deleted ?? this.deleted,
    );
  }
}
