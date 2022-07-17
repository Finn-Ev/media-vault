import 'package:media_vault/domain/entities/auth/user_id.dart';

class Asset {
  final UniqueID id;
  final String url;
  final dynamic createdAt;
  final dynamic uploadedAt;

  Asset({
    required this.id,
    required this.url,
    required this.createdAt,
    required this.uploadedAt,
  });

  factory Asset.empty() {
    return Asset(id: UniqueID(), url: "", createdAt: DateTime.now(), uploadedAt: DateTime.now());
  }

  Asset copyWith({
    UniqueID? id,
    String? url,
    DateTime? createdAt,
    DateTime? uploadedAt,
  }) {
    return Asset(
      id: id ?? this.id,
      url: url ?? this.url,
      createdAt: createdAt ?? this.createdAt,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}
