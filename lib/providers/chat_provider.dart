import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import 'package:chatbotapp/models/message.dart';
import 'package:chatbotapp/services/ai_service.dart';

class ChatProvider extends ChangeNotifier {
  final Box _settingsBox = Hive.box('settings');
  final Box _chatsBox = Hive.box('chats');
  final Box _messagesBox = Hive.box('messages');
  final _uuid = const Uuid();

  String? _currentChatId;
  List<XFile>? _imagesFileList;
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  bool _isLoading = false;

  // Getters
  String? get currentChatId => _currentChatId;
  List<XFile>? get imagesFileList => _imagesFileList;
  int get currentIndex => _currentIndex;
  PageController get pageController => _pageController;
  bool get isLoading => _isLoading;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  List<Message> get messages {
    if (_currentChatId == null) return [];
    final chatMessages = _messagesBox.values
        .where((msg) => msg.chatId == _currentChatId)
        .cast<Message>()
        .toList();
    chatMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return chatMessages;
  }

  List<Map<String, dynamic>> get chats {
    final chats = _chatsBox.values.map((chat) {
      final lastMessage = _messagesBox.values
          .where((msg) => msg.chatId == chat['id'])
          .cast<Message>()
          .toList()
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

      return {
        'id': chat['id'],
        'lastMessage':
            lastMessage.isNotEmpty ? lastMessage.first.content : 'New Chat',
        'updatedAt': lastMessage.isNotEmpty
            ? lastMessage.first.timestamp.toIso8601String()
            : DateTime.now().toIso8601String(),
      };
    }).toList();

    chats.sort((a, b) => b['updatedAt'].compareTo(a['updatedAt']));
    return chats;
  }

  // Methods
  void setCurrentChatId(String chatId) {
    _currentChatId = chatId;
    notifyListeners();
  }

  Future<void> createNewChat() async {
    final chatId = _uuid.v4();
    await _chatsBox.add({'id': chatId});
    setCurrentChatId(chatId);
    setCurrentIndex(1);
    _pageController.jumpToPage(1);
  }

  Future<void> deleteChat(String chatId) async {
    try {
      // Delete chat
      final chatEntries = _chatsBox.toMap().entries.toList();
      final chatEntry = chatEntries.firstWhere(
        (entry) => (entry.value as Map)['id'] == chatId,
        orElse: () => throw Exception('Chat not found'),
      );
      await _chatsBox.delete(chatEntry.key);

      // Delete associated messages
      final messageEntries = _messagesBox.toMap().entries.toList();
      final messageKeys = messageEntries
          .where((entry) => (entry.value as Message).chatId == chatId)
          .map((entry) => entry.key)
          .toList();

      for (final key in messageKeys) {
        await _messagesBox.delete(key);
      }

      if (_currentChatId == chatId) {
        _currentChatId = null;
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting chat: $e');
    }
  }

  Future<void> sendMessage(String content) async {
    if (_currentChatId == null) {
      await createNewChat();
    }

    _isLoading = true;
    notifyListeners();

    try {
      // Add user message
      final userMessage = Message(
        id: _uuid.v4(),
        chatId: _currentChatId!,
        role: MessageRole.user,
        content: content,
      );
      await _messagesBox.add(userMessage);
      notifyListeners();

      // Get AI response
      final response = await AIService.generateResponse(content);
      print(response.toString());
      // Add AI message
      final aiMessage = Message(
        id: _uuid.v4(),
        chatId: _currentChatId!,
        role: MessageRole.assistant,
        content: response,
      );
      await _messagesBox.add(aiMessage);
    } catch (e) {
      debugPrint('Error sending message: $e');
      // Add error message
      final errorMessage = Message(
        id: _uuid.v4(),
        chatId: _currentChatId!,
        role: MessageRole.assistant,
        content: 'Sorry, I encountered an error. Please try again.',
      );
      await _messagesBox.add(errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();

    if (images.isNotEmpty) {
      _imagesFileList = images;
      notifyListeners();
    }
  }

  void removeImage(int index) {
    _imagesFileList?.removeAt(index);
    notifyListeners();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
