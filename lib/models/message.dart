import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 0)
class Message extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String chatId;

  @HiveField(2)
  final MessageRole role;

  @HiveField(3)
  final String content;

  @HiveField(4)
  final List<String> imageUrls;

  @HiveField(5)
  final DateTime timestamp;

  Message({
    required this.id,
    required this.chatId,
    required this.role,
    required this.content,
    this.imageUrls = const [],
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as String,
      chatId: map['chatId'] as String,
      role: MessageRole.values.firstWhere(
        (r) => r.toString() == map['role'],
        orElse: () => MessageRole.user,
      ),
      content: map['content'] as String,
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      timestamp: DateTime.parse(map['timestamp'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chatId': chatId,
      'role': role.toString(),
      'content': content,
      'imageUrls': imageUrls,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  Message copyWith({
    String? id,
    String? chatId,
    MessageRole? role,
    String? content,
    List<String>? imageUrls,
    DateTime? timestamp,
  }) {
    return Message(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      role: role ?? this.role,
      content: content ?? this.content,
      imageUrls: imageUrls ?? this.imageUrls,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Message addImages(List<String> newImageUrls) {
    return copyWith(
      imageUrls: [...imageUrls, ...newImageUrls],
    );
  }

  @override
  String toString() => content;
}

@HiveType(typeId: 1)
enum MessageRole {
  @HiveField(0)
  user,
  @HiveField(1)
  assistant,
}