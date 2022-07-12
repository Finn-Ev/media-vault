import 'package:uuid/uuid.dart';

class UniqueID {
  final String value;

  const UniqueID._(this.value);

  factory UniqueID() {
    return UniqueID._(const Uuid().v4());
  }

  factory UniqueID.fromString(String uniqueID) {
    return UniqueID._(uniqueID);
  }

  @override
  String toString() => value;
}
