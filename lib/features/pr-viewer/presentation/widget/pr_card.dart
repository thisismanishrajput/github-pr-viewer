import 'package:flutter/material.dart';
import '../../data/model/pr_viewer_model.dart';

class PullRequestCard extends StatelessWidget {
  final PullRequest pr;

  const PullRequestCard({super.key, required this.pr});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// PR Title
            Text(
              pr.title ?? "N/A",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            /// PR Body
            Text(
              pr.body?.isNotEmpty == true
                  ? pr.body!
                  : 'No description provided',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 12),

            /// Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Author: ${pr.user?.login}',
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  _formatDate(pr.createdAt),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if(date == null) return "N/A";
    return '${date.day}/${date.month}/${date.year}';
  }
}
