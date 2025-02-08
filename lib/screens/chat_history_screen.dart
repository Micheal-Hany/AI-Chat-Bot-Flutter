import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatbotapp/providers/chat_provider.dart';
import 'package:chatbotapp/widgets/chat_history_widget.dart';
import 'package:chatbotapp/widgets/empty_history_widget.dart';

class ChatHistoryScreen extends StatelessWidget {
  const ChatHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, _) {
        return Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            title: Text(
              'Chat History',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => chatProvider.createNewChat(),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: chatProvider.chats.isEmpty
              ? const EmptyHistoryWidget()
              : const ChatHistoryWidget(),
        );
      },
    );
  }
}
