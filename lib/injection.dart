import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:media_vault/application/albums/observer/album_observer_bloc.dart';
import 'package:media_vault/application/auth/auth_core/auth_core_bloc.dart';
import 'package:media_vault/application/auth/auth_form/auth_form_bloc.dart';
import 'package:media_vault/domain/repositories/album_repository.dart';
import 'package:media_vault/domain/repositories/auth_repository.dart';
import 'package:media_vault/infrastructure/repositories/album_repository_impl.dart';
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
  sl.registerFactory(() => AlbumObserverBloc(albumRepository: sl()));
  // repositories
  sl.registerLazySingleton<AlbumRepository>(() => AlbumRepositoryImpl(firestore: sl()));
  // external
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Assets
  // state management
  // repositories
  // external
}
