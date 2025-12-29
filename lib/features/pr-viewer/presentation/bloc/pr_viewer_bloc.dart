import 'dart:async';
import 'package:github_pr_viewer/features/pr-viewer/domain/repo/pr_viewer_repo.dart';
import 'package:github_pr_viewer/features/pr-viewer/presentation/bloc/pr_viewer_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_pr_viewer/features/pr-viewer/presentation/bloc/pr_viewer_state.dart';

import '../../../../services/service_locator.dart';
import '../../../../utility/result.dart';
import '../../data/model/pr_viewer_model.dart';

class PrViewerBloc extends Bloc<PrViewerEvent, PrViewerState> {
  PrViewerBloc() : super(  const PrViewerState()) {
    on<FetchPullRequestEvent>(_onFetchPullRequestEvent);
  }

  final PrViewerRepo _prViewerRepo = serviceLocator<PrViewerRepo>();

  FutureOr<void> _onFetchPullRequestEvent(
      FetchPullRequestEvent event,
      Emitter<PrViewerState> emit,
      ) async {
    emit(state.copyWith(
      pullRequestStatus: StateUpdateStatus.updating,
    ));

    final result = await _prViewerRepo.fetchPullRequests();

    if (result is Failure) {
      emit(state.copyWith(
        pullRequestStatus: StateUpdateStatus.failed,
        pulRequests: [],
      ));
    } else if (result is Success<List<PullRequest>>) {
      emit(state.copyWith(
        pullRequestStatus: StateUpdateStatus.success,
        pulRequests: result.data,
      ));
    }
  }

}
