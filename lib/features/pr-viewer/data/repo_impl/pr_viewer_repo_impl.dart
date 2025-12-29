import 'dart:async';
import 'package:github_pr_viewer/utility/result.dart';

import '../../../../api_integration/api_constants.dart';
import '../../../../api_integration/dio_client.dart';
import '../../../../services/service_locator.dart';
import '../../domain/repo/pr_viewer_repo.dart';
import '../model/pr_viewer_model.dart';

class PrViewerRepoImpl extends PrViewerRepo {
  final DioClient _dio = serviceLocator<DioClient>();

  @override
  Future<Result<List<PullRequest>>> fetchPullRequests() async {
    final result = await _dio.get(APIEndPoints.prSlug);

    // First check if it's a Failure, then cast to access message
    if (result is Failure) {
      return Failure((result).message);
    }

    final data = (result as Success).data;

    try {
      if (data is List) {
        final pullRequests = PullRequest.fromJsonList(data);
        return Success(pullRequests);
      } else {
        return Failure('Expected a list of pull requests but got: ${data.runtimeType}');
      }
    } catch (e) {
      return Failure(e.toString());
    }
  }
}