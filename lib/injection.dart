import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:media_vault/features/albums/application/controller/album_controller_bloc.dart';
import 'package:media_vault/features/albums/application/observer/album_observer_bloc.dart';
import 'package:media_vault/features/albums/domain/repositories/album_repository.dart';
import 'package:media_vault/features/albums/infrastructure/repositories/album_repository_impl.dart';
import 'package:media_vault/features/assets/application/asset_carousel/asset_carousel_bloc.dart';
import 'package:media_vault/features/assets/application/asset_list/asset_list_bloc.dart';
import 'package:media_vault/features/assets/application/controller/asset_controller_bloc.dart';
import 'package:media_vault/features/assets/application/observer/asset_observer_bloc.dart';
import 'package:media_vault/features/assets/domain/repositories/asset_repository.dart';
import 'package:media_vault/features/assets/infrastructure/repositories/asset_repository_impl.dart';
import 'package:media_vault/features/auth/application/local_auth/local_auth_bloc.dart';
import 'package:media_vault/features/auth/application/remote_auth/remote_auth_core/remote_auth_core_bloc.dart';
import 'package:media_vault/features/auth/application/remote_auth/remote_auth_form/remote_auth_form_bloc.dart';
import 'package:media_vault/features/auth/domain/repositories/local_auth_repository.dart';
import 'package:media_vault/features/auth/domain/repositories/remote_auth_repository.dart';
import 'package:media_vault/features/auth/infrastructure/repositories/local_auth_repository_impl.dart';
import 'package:media_vault/features/auth/infrastructure/repositories/remote_auth_repository_impl.dart';

import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.I;

Future<void> init() async {
  // Firebase
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);

  // Remote-Auth
  // state management
  sl.registerFactory(() => AuthFormBloc(authRepository: sl()));
  sl.registerFactory(() => AuthCoreBloc(authRepository: sl()));
  // repositories
  sl.registerLazySingleton<RemoteAuthRepository>(
      () => AuthRepositoryImpl(firebaseAuth: sl(), albumRepository: sl()));

  // Local-Auth
  // state management
  sl.registerFactory(() => LocalAuthBloc(localAuthRepository: sl()));
  // repositories
  sl.registerLazySingleton<LocalAuthRepository>(() => LocalAuthRepositoryImpl(sharedPreferences: sl()));
  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Albums
  // state management
  sl.registerFactory(() => AlbumObserverBloc(albumRepository: sl()));
  sl.registerFactory(() => AlbumControllerBloc(albumRepository: sl()));

  // repositories
  sl.registerLazySingleton<AlbumRepository>(
      () => AlbumRepositoryImpl(firestore: sl(), storage: sl(), assetRepository: sl()));

  // Assets
  // state management
  sl.registerFactory(() => AssetObserverBloc(assetRepository: sl()));
  sl.registerFactory(() => AssetControllerBloc(assetRepository: sl()));
  sl.registerFactory(() => AssetListBloc());
  sl.registerFactory(() => AssetCarouselBloc());
  // repositories
  sl.registerLazySingleton<AssetRepository>(() => AssetRepositoryImpl(firestore: sl(), storage: sl()));
}
