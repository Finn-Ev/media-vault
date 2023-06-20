import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:media_vault/core/errors/custom_errors.dart';
import 'package:media_vault/features/auth/domain/entities/user.dart';
import 'package:media_vault/features/auth/domain/repositories/remote_auth_repository.dart';
import 'package:media_vault/injection.dart';

extension FirebaseUserMapper on User {
  CustomUser toCustomUser() {
    return CustomUser(id: uid, email: email!, emailVerified: emailVerified);
  }
}

extension FirestoreExt on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = sl<RemoteAuthRepository>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());

    return FirebaseFirestore.instance.collection("users").doc(user.id);
  }
}

extension DocumentReferenceExt on DocumentReference {
  CollectionReference<Map<String, dynamic>> get albumCollection => collection("albums");
}
