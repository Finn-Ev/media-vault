import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:media_vault/application/auth/auth_core/auth_core_bloc.dart';
import 'package:media_vault/application/auth/auth_form/auth_form_bloc.dart';
import 'package:media_vault/domain/repositories/auth_repository.dart';
import 'package:media_vault/infrastructure/repositories/auth_repository_impl.dart';

final sl = GetIt.I;

Future<void> init() async {
  // Auth
  // state management
  sl.registerFactory(() => AuthFormBloc(authRepository: sl()));
  sl.registerFactory(() => AuthCoreBloc(authRepository: sl()));
  //sl.registerFactory(() => AuthBloc(authRepository: sl()));
  // repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(firebaseAuth: sl()));
  // external
  sl.registerLazySingleton(() => FirebaseAuth.instance);

  // Albums
  // state management
  // repositories
  // external

  // Assets
  // state management
  // repositories
  // external
}
