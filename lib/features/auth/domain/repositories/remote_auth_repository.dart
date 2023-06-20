import 'package:dartz/dartz.dart';
import 'package:media_vault/core/failures/remote_auth_failures.dart';
import 'package:media_vault/features/auth/domain/entities/user.dart';

abstract class RemoteAuthRepository {
  Future<Either<RemoteAuthFailure, Unit>> registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<RemoteAuthFailure, Unit>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<RemoteAuthFailure, Unit>> signInWithGoogle();

  Future<Either<RemoteAuthFailure, Unit>> signInWithApple();

  Future<Either<RemoteAuthFailure, Unit>> sendPasswordResetEmail({
    required String email,
  });

  Future<void> signOut();

  Option<CustomUser> getSignedInUser();
}
