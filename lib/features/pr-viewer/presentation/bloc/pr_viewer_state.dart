import 'package:equatable/equatable.dart';

import '../../data/model/pr_viewer_model.dart';

enum StateUpdateStatus { none, updating, success, failed }

class PrViewerState extends Equatable {
  final List<PullRequest> pulRequests;
  final StateUpdateStatus pullRequestStatus;

  const PrViewerState({this.pulRequests = const [], this.pullRequestStatus = StateUpdateStatus.none});

  PrViewerState copyWith({List<PullRequest>? pulRequests, StateUpdateStatus? pullRequestStatus}) {
    return PrViewerState(pullRequestStatus: pullRequestStatus ?? this.pullRequestStatus, pulRequests: pulRequests ?? this.pulRequests);
  }

  @override
  List<Object?> get props => [pulRequests, pullRequestStatus];
}
