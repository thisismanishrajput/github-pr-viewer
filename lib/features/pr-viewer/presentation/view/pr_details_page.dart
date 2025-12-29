import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../data/model/pr_viewer_model.dart';

class PullRequestDetailsScreen extends StatelessWidget {
  final PullRequest pr;

  const PullRequestDetailsScreen({
    super.key,
    required this.pr,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pull Request Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            ZoomIn(
              duration: const Duration(milliseconds: 400),
              child: Text(
                pr.title ?? 'N/A',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// Meta Info
            FadeInLeft(
              duration: const Duration(milliseconds: 500),
              child: Row(
                children: [
                  Icon(Icons.person,
                      size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 6),
                  Text(
                    pr.user?.login ?? 'Unknown',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.calendar_today,
                      size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 6),
                  Text(
                    _formatDate(pr.createdAt),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Divider(),

            const SizedBox(height: 12),

            /// Description title
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: const Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 8),

            /// Description body
            FadeInUp(
              delay: const Duration(milliseconds: 150),
              duration: const Duration(milliseconds: 500),
              child: Text(
                pr.body?.isNotEmpty == true
                    ? pr.body!
                    : 'No description provided',
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.day}/${date.month}/${date.year}';
  }
}
