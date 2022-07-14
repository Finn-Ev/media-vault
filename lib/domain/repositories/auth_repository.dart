import 'package:dartz/dartz.dart';
import 'package:media_vault/core/failures/auth_failures.dart';
import 'package:media_vault/domain/entities/auth/user.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<AuthFailure, Unit>> signInWithGoogle();

  Future<Either<AuthFailure, Unit>> signInWithApple();

  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail({
    required String email,
  });

  Future<void> signOut();

  Option<CustomUser> getSignedInUser();
}
