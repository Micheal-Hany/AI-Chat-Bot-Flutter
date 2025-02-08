import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatbotapp/providers/chat_provider.dart';
import 'package:chatbotapp/widgets/preview_images_widget.dart';

// class BottomChatField extends StatefulWidget {
//   final ScrollController scrollController;

//   const BottomChatField({
//     super.key,
//     required this.scrollController,
//   });

//   @override
//   State<BottomChatField> createState() => _BottomChatFieldState();
// }

// class _BottomChatFieldState extends State<BottomChatField> {
//   late TextEditingController _messageController;
//   bool _isComposing = false;

//   @override
//   void initState() {
//     super.initState();
//     _messageController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     super.dispose();
//   }

//   void _handleSubmitted(String text) {
//     if (text.trim().isEmpty) return;

//     final chatProvider = context.read<ChatProvider>();
//     chatProvider.sendMessage(text.trim());

//     _messageController.clear();
//     setState(() {
//       _isComposing = false;
//     });

//     // Scroll to bottom after message is sent
//     Future.delayed(const Duration(milliseconds: 100), () {
//       if (widget.scrollController.hasClients) {
//         widget.scrollController.animateTo(
//           widget.scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Column(
//       children: [
//         const PreviewImagesWidget(),
//         Container(
//           decoration: BoxDecoration(
//             color: theme.colorScheme.surface,
//             boxShadow: [
//               BoxShadow(
//                 color: theme.colorScheme.shadow.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: const Offset(0, -5),
//               ),
//             ],
//           ),
//           child: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 16,
//                 vertical: 8,
//               ),
//               child: Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       context.read<ChatProvider>().pickImages();
//                     },
//                     icon: Icon(
//                       Icons.image_outlined,
//                       color: theme.colorScheme.onSurfaceVariant,
//                     ),
//                   ),
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       onChanged: (text) {
//                         setState(() {
//                           _isComposing = text.trim().isNotEmpty;
//                         });
//                       },
//                       onSubmitted: _isComposing ? _handleSubmitted : null,
//                       decoration: InputDecoration(
//                         hintText: 'Type a message',
//                         hintStyle: TextStyle(
//                           color: theme.colorScheme.onSurfaceVariant,
//                         ),
//                         border: InputBorder.none,
//                       ),
//                       maxLines: null,
//                       textCapitalization: TextCapitalization.sentences,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: _isComposing
//                         ? () => _handleSubmitted(_messageController.text)
//                         : null,
//                     icon: Icon(
//                       Icons.send,
//                       color: _isComposing
//                           ? theme.colorScheme.primary
//                           : theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatbotapp/providers/chat_provider.dart';
import 'package:chatbotapp/widgets/preview_images_widget.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class BottomChatField extends StatefulWidget {
  final ScrollController scrollController;

  const BottomChatField({
    super.key,
    required this.scrollController,
  });

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  late TextEditingController _messageController;
  bool _isComposing = false;
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _speech = stt.SpeechToText();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    final chatProvider = context.read<ChatProvider>();
    chatProvider.sendMessage(text.trim());

    _messageController.clear();
    setState(() {
      _isComposing = false;
    });

    // Scroll to bottom after message is sent
    Future.delayed(const Duration(milliseconds: 100), () {
      if (widget.scrollController.hasClients) {
        widget.scrollController.animateTo(
          widget.scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          setState(() {
            _isListening = status == 'listening';
          });
        },
        onError: (error) {
          setState(() {
            _isListening = false;
          });
        },
      );

      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (result) {
            setState(() {
              _messageController.text = result.recognizedWords;
              _isComposing = result.recognizedWords.isNotEmpty;
            });
          },
        );
      }
    } else {
      setState(() {
        _isListening = false;
      });
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const PreviewImagesWidget(),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Row(
                children: [
                  // Image Picker Button
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {
                        context.read<ChatProvider>().pickImages();
                      },
                      icon: Icon(
                        Icons.image_outlined,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Text Field
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            theme.colorScheme.surfaceVariant.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _messageController,
                          onChanged: (text) {
                            setState(() {
                              _isComposing = text.trim().isNotEmpty;
                            });
                          },
                          onSubmitted: _isComposing ? _handleSubmitted : null,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            hintStyle: TextStyle(
                              color: theme.colorScheme.onSurfaceVariant
                                  .withOpacity(0.6),
                            ),
                            border: InputBorder.none,
                          ),
                          maxLines: null,
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Microphone Button
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: _isListening
                          ? theme.colorScheme.primary.withOpacity(0.2)
                          : theme.colorScheme.surfaceVariant.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: _listen,
                      icon: Icon(
                        _isListening ? Icons.mic : Icons.mic_none,
                        color: _isListening
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Send Button
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: _isComposing
                          ? theme.colorScheme.primary
                          : theme.colorScheme.surfaceVariant.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: _isComposing
                          ? () => _handleSubmitted(_messageController.text)
                          : null,
                      icon: Icon(
                        Icons.send,
                        color: _isComposing
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onSurfaceVariant
                                .withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
