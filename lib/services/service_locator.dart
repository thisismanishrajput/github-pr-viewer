import 'package:github_pr_viewer/features/pr-viewer/data/repo_impl/pr_viewer_repo_impl.dart';
import 'package:github_pr_viewer/features/pr-viewer/domain/repo/pr_viewer_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../api_integration/dio_client.dart';
import '../api_integration/dio_client_x.dart';
import '../features/auth/data/repo_impl/auth_repo_impl.dart';
import '../features/auth/data/service/auth_local_service.dart';
import '../features/auth/domain/repo/auth_repo.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerLazySingleton<DioClient>(() => DioClient());
  serviceLocator.registerLazySingleton<Dio>(() => DioClientX().provideDio());
  serviceLocator.registerLazySingleton<PrViewerRepo>(() => PrViewerRepoImpl());
  serviceLocator.registerLazySingleton<AuthLocalService>(() => AuthLocalService());
  serviceLocator.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(serviceLocator<AuthLocalService>()));
  serviceLocator.registerFactory<AuthBloc>(() => AuthBloc(serviceLocator<AuthRepo>()));
}
