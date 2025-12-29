import '../../../../utility/result.dart';
import '../../data/model/pr_viewer_model.dart';

abstract class PrViewerRepo {
  Future<Result<List<PullRequest>>> fetchPullRequests();
}

