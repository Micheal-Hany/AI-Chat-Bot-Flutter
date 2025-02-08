import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatbotapp/providers/chat_provider.dart';
import 'package:chatbotapp/widgets/chat_messages.dart';
import 'package:chatbotapp/widgets/bottom_chat_field.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ChatProvider>(
//       builder: (context, chatProvider, _) {
//         return Scaffold(
//           appBar: AppBar(
//             forceMaterialTransparency: true,
//             title: Text(
//               chatProvider.currentChatId == null ? 'New Chat' : 'Chat',
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//             centerTitle: true,
//             actions: [
//               if (chatProvider.currentChatId != null)
//                 IconButton(
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: const Text('Delete Chat'),
//                         content: const Text(
//                             'Are you sure you want to delete this chat?'),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context),
//                             child: const Text('Cancel'),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               chatProvider
//                                   .deleteChat(chatProvider.currentChatId!);
//                               Navigator.pop(context);
//                               chatProvider.setCurrentIndex(0);
//                               chatProvider.pageController.jumpToPage(0);
//                             },
//                             style: TextButton.styleFrom(
//                               foregroundColor:
//                                   Theme.of(context).colorScheme.error,
//                             ),
//                             child: const Text('Delete'),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   icon: Icon(
//                     Icons.delete_outline,
//                     color: Theme.of(context).colorScheme.error,
//                   ),
//                 ),
//             ],
//           ),
//           body: Column(
//             children: [
//               Expanded(
//                 child: Stack(
//                   children: [
//                     ChatMessages(
//                       scrollController: _scrollController,
//                     ),
//                     if (chatProvider.isLoading)
//                       Positioned(
//                         bottom: 0,
//                         left: 0,
//                         right: 0,
//                         child: Container(
//                           padding: const EdgeInsets.all(16),
//                           color: Theme.of(context).colorScheme.surface,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 width: 16,
//                                 height: 16,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   color: Theme.of(context).colorScheme.primary,
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               Text(
//                                 'AI is thinking...',
//                                 style: TextStyle(
//                                   color:
//                                       Theme.of(context).colorScheme.onSurface,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//               BottomChatField(
//                 scrollController: _scrollController,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatbotapp/providers/chat_provider.dart';
import 'package:chatbotapp/widgets/chat_messages.dart';
import 'package:chatbotapp/widgets/bottom_chat_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, _) {
        return Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            title: Text(
              chatProvider.currentChatId == null ? 'New Chat' : 'Chat',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            centerTitle: true,
            actions: [
              if (chatProvider.currentChatId != null)
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Chat'),
                        content: const Text(
                            'Are you sure you want to delete this chat?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              chatProvider
                                  .deleteChat(chatProvider.currentChatId!);
                              Navigator.pop(context);
                              chatProvider.setCurrentIndex(0);
                              chatProvider.pageController.jumpToPage(0);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).colorScheme.error,
                            ),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
            ],
          ),
          body: Column(
            children: [
              // Chat Messages
              Expanded(
                child: Stack(
                  children: [
                    ChatMessages(
                      scrollController: _scrollController,
                    ),
                    if (chatProvider.isLoading)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          color: Theme.of(context).colorScheme.surface,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'AI is thinking...',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Bottom Chat Field
              BottomChatField(
                scrollController: _scrollController,
              ),
            ],
          ),
        );
      },
    );
  }
}
