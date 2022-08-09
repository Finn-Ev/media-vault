import 'package:dartz/dartz.dart';
import 'package:media_vault/core/failures/local_auth_failures.dart';

abstract class LocalAuthRepository {
  Future<Either<LocalAuthFailure, Unit>> savePIN({
    required String pin,
  });

  Future<Either<LocalAuthFailure, String?>> getSavedPIN();

  Future<Either<LocalAuthFailure, Unit>> updateSavedPIN({
    required String newPin,
  });

  Future<Either<LocalAuthFailure, Unit>> deleteSavedPIN();
}
