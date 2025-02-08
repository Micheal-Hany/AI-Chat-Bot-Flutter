import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:chatbotapp/models/message.dart';
import 'package:chatbotapp/providers/chat_provider.dart';
import 'package:chatbotapp/widgets/assistant_message_widget.dart';
import 'package:chatbotapp/widgets/my_message_widget.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, _) {
        if (chatProvider.currentChatId == null) {
          return const Center(
            child: Text('Select or start a new chat'),
          );
        }

        final messages = chatProvider.messages;
        if (messages.isEmpty) {
          return const Center(
            child: Text('No messages yet'),
          );
        }

        return ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isUser = message.role == MessageRole.user;
            
            return AnimatedPadding(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.only(
                top: 8,
                bottom: 8,
                left: isUser ? 32 : 8,
                right: isUser ? 8 : 32,
              ),
              child: isUser
                  ? MyMessageWidget(message: message)
                  : AssistantMessageWidget(message: message),
            ).animate()
              .fadeIn(duration: 300.ms)
              .slideY(begin: 0.2, end: 0, duration: 300.ms);
          },
        );
      },
    );
  }
}
