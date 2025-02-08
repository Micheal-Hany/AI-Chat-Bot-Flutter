import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import 'package:chatbotapp/providers/chat_provider.dart';

class EmptyHistoryWidget extends StatelessWidget {
  const EmptyHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.chat_bubble_2,
            size: 100,
            color: theme.colorScheme.primary.withOpacity(0.5),
          ).animate()
            .fadeIn(duration: 600.ms)
            .scale(delay: 200.ms),
          
          const SizedBox(height: 20),
          
          Text(
            'No Chat History',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onBackground,
            ),
          ).animate()
            .fadeIn(delay: 200.ms)
            .slideY(begin: 0.3, end: 0),
          
          const SizedBox(height: 12),
          
          Text(
            'Start a new conversation',
            style: TextStyle(
              fontSize: 16,
              color: theme.colorScheme.onBackground.withOpacity(0.7),
            ),
          ).animate()
            .fadeIn(delay: 400.ms)
            .slideY(begin: 0.3, end: 0),
          
          const SizedBox(height: 40),
          
          _buildNewChatButton(context),
        ],
      ),
    );
  }

  Widget _buildNewChatButton(BuildContext context) {
    final theme = Theme.of(context);
    
    return ElevatedButton.icon(
      onPressed: () {
        final chatProvider = context.read<ChatProvider>();
        chatProvider.createNewChat().then((_) {
          chatProvider.setCurrentIndex(1);
          chatProvider.pageController.jumpToPage(1);
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      icon: const Icon(CupertinoIcons.add),
      label: const Text(
        'New Chat',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ).animate()
      .fadeIn(delay: 600.ms)
      .scale(delay: 600.ms)
      .shimmer(delay: 800.ms, duration: 1200.ms);
  }
}
