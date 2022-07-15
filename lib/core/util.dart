import 'dart:convert';

import 'package:crypto/crypto.dart';

String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

// String generateNonce([int length = 32]) {
//   const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
//   final random = Random.secure();
//   return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
// }
