import 'package:dartz/dartz.dart';
import 'package:media_vault/core/failures/local_auth_failures.dart';
import 'package:media_vault/features/auth/domain/repositories/local_auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const pinKey = 'pin';

class LocalAuthRepositoryImpl extends LocalAuthRepository {
  final SharedPreferences sharedPreferences;
  LocalAuthRepositoryImpl({required this.sharedPreferences});

  @override
  Future<Either<LocalAuthFailure, Unit>> savePIN({required String pin}) async {
    try {
      await sharedPreferences.setString(pinKey, pin);
      return right(unit);
    } catch (e) {
      return left(GeneralLocalAuthFailure());
    }
  }

  @override
  Future<Either<LocalAuthFailure, String?>> getSavedPIN() async {
    try {
      final pin = sharedPreferences.getString(pinKey);
      return right(pin);
    } catch (e) {
      return left(GeneralLocalAuthFailure());
    }
  }

  @override
  Future<Either<LocalAuthFailure, Unit>> updateSavedPIN({required String newPin}) async {
    try {
      await sharedPreferences.setString(pinKey, newPin);
      return right(unit);
    } catch (e) {
      return left(GeneralLocalAuthFailure());
    }
  }

  @override
  Future<Either<LocalAuthFailure, Unit>> deleteSavedPIN() async {
    try {
      await sharedPreferences.remove(pinKey);
      return right(unit);
    } catch (e) {
      return left(GeneralLocalAuthFailure());
    }
  }
}
