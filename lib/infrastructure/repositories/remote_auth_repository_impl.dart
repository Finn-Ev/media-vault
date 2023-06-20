import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:media_vault/constants.dart';
import 'package:media_vault/core/failures/remote_auth_failures.dart';
import 'package:media_vault/domain/entities/auth/user.dart';
import 'package:media_vault/domain/repositories/album_repository.dart';
import 'package:media_vault/domain/repositories/remote_auth_repository.dart';
import 'package:media_vault/infrastructure/extensions/firebase_extensions.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRepositoryImpl implements RemoteAuthRepository {
  final FirebaseAuth firebaseAuth;
  final AlbumRepository albumRepository;

  AuthRepositoryImpl({required this.firebaseAuth, required this.albumRepository});

  @override
  Future<Either<RemoteAuthFailure, Unit>> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final user = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      user.user!.sendEmailVerification();

      if (user.additionalUserInfo?.isNewUser == true) {
        albumRepository.createTrash();
      }

      // firebaseAuth.signOut();

      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(EmailAlreadyInUseFailure());
      } else {
        return left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<RemoteAuthFailure, Unit>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final user = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      // don't allow the user to login if the email is not verified
      if (!user.user!.emailVerified) {
        await user.user!.sendEmailVerification();
        return left(EmailNotVerifiedFailure());
      }

      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'user-not-found') {
        return left(InvalidEmailAndPasswordCombinationFailure());
      } else {
        return left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<RemoteAuthFailure, Unit>> sendPasswordResetEmail({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return right(unit);
    } on FirebaseAuthException {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<RemoteAuthFailure, Unit>> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: kFirebaseClientId,
      scopes: [
        'email',
      ],
    );

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final result = await firebaseAuth.signInWithCredential(credential);

        if (result.additionalUserInfo?.isNewUser == true) {
          albumRepository.createTrash();
        }

        return right(unit);
      } on FirebaseAuthException catch (e) {
        if (kDebugMode) {
          print(e);
        }
        if (e.code == 'account-exists-with-different-credential') {
          left(EmailAlreadyInUseFailure());
        }
        return left(ServerFailure());
      }
    } else {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<RemoteAuthFailure, Unit>> signInWithApple() async {
    String sha256ofString(String input) {
      final bytes = utf8.encode(input);
      final digest = sha256.convert(bytes);
      return digest.toString();
    }

    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      final result = await firebaseAuth.signInWithCredential(oauthCredential);

      if (result.additionalUserInfo?.isNewUser == true) {
        albumRepository.createTrash();
      }

      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (e.code == 'account-exists-with-different-credential') {
        left(EmailAlreadyInUseFailure());
      }
      return left(ServerFailure());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return left(ServerFailure());
    }
  }

  @override
  Future<void> signOut() => Future.wait([firebaseAuth.signOut()]);

  @override
  Option<CustomUser> getSignedInUser() => optionOf(firebaseAuth.currentUser?.toCustomUser());
}
