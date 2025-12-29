import 'package:github_pr_viewer/features/pr-viewer/data/repo_impl/pr_viewer_repo_impl.dart';
import 'package:github_pr_viewer/features/pr-viewer/domain/repo/pr_viewer_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../api_integration/dio_client.dart';
import '../api_integration/dio_client_x.dart';


final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerLazySingleton<DioClient>(() => DioClient());
  serviceLocator.registerLazySingleton<Dio>(() => DioClientX().provideDio());
  serviceLocator.registerLazySingleton<PrViewerRepo>(() => PrViewerRepoImpl());
}
