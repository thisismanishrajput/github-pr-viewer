import 'package:animate_do/animate_do.dart';
import 'package:github_pr_viewer/features/pr-viewer/presentation/bloc/pr_viewer_bloc.dart';
import 'package:github_pr_viewer/features/pr-viewer/presentation/bloc/pr_viewer_event.dart';
import 'package:github_pr_viewer/features/pr-viewer/presentation/bloc/pr_viewer_state.dart';
import 'package:github_pr_viewer/features/pr-viewer/presentation/widget/pr_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';


class PullRequestScreen extends StatefulWidget {
  const PullRequestScreen({super.key});

  @override
  State<PullRequestScreen> createState() => _PullRequestScreenState();
}

class _PullRequestScreenState extends State<PullRequestScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PrViewerBloc>().add(FetchPullRequestEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Pull Requests'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
          ),
        ],
      ),
      body: BlocBuilder<PrViewerBloc, PrViewerState>(
        builder: (context, state) {
          if (state.pullRequestStatus == StateUpdateStatus.updating) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.pullRequestStatus == StateUpdateStatus.failed) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<PrViewerBloc>().add(FetchPullRequestEvent());
                    },
                    child: Text("Retry"),
                  ),
                  Text('Something went wrong'),
                ],
              ),
            );
          }

          if (state.pullRequestStatus == StateUpdateStatus.success && state.pulRequests.isEmpty) {
            return const Center(child: Text('No open pull requests found'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<PrViewerBloc>().add(FetchPullRequestEvent());
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.pulRequests.length,
              itemBuilder: (context, index) {
                return FadeInLeft(
                  delay: Duration(milliseconds: index*50),
                    child: PullRequestCard(pr: state.pulRequests[index]));
              },
            ),
          );
        },
      ),
    );
  }
}
