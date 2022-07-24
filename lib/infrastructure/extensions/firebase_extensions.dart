import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:media_vault/core/errors/custom_errors.dart';
import 'package:media_vault/domain/entities/auth/user.dart';
import 'package:media_vault/domain/repositories/auth_repository.dart';
import 'package:media_vault/injection.dart';

extension FirebaseUserMapper on User {
  CustomUser toCustomUser() {
    return CustomUser(id: uid);
  }
}

extension FirestoreExt on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());

    return FirebaseFirestore.instance.collection("users").doc(user.id);
  }
}

extension DocumentReferenceExt on DocumentReference {
  CollectionReference<Map<String, dynamic>> get albumCollection => collection("albums");
}
