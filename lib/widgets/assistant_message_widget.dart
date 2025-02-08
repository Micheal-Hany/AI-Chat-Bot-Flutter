import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:chatbotapp/models/message.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class AssistantMessageWidget extends StatelessWidget {
  final Message message;

  const AssistantMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timeAgo = timeago.format(message.timestamp);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display Images in a Grid if available
        if (message.imageUrls.isNotEmpty) ...[
          SizedBox(
            height: 150,
            child: GridView.builder(
              itemCount: message.imageUrls.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Single row of images
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    message.imageUrls[index],
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
        ],

        // Message Bubble with Markdown Support
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 280, // Prevent overly wide messages
            ),
            child: MarkdownBody(
              data: message.content,
              selectable: true,
              onTapLink: (text, url, title) {
                if (url != null) launchUrl(Uri.parse(url));
              },
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(
                    fontSize: 16, color: theme.colorScheme.onSurfaceVariant),
                strong: const TextStyle(fontWeight: FontWeight.bold),
                a: TextStyle(
                    color: theme.colorScheme.primary,
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
        ),

        // Timestamp Below Message
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 4),
          child: Text(
            timeAgo,
            style: TextStyle(
              fontSize: 12,
              color: theme.colorScheme.onBackground.withOpacity(0.6),
            ),
          ),
        ),
      ],
    );
  }
}
