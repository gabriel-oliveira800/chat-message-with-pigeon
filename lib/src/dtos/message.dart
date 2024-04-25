import 'package:uuid/uuid.dart';

typedef Messages = List<Message>;

class Message {
  final String id;
  final String name;
  final String message;
  final DateTime createdAt;

  const Message({
    required this.id,
    required this.name,
    required this.message,
    required this.createdAt,
  });

  factory Message.generateId(String message, String name) {
    return Message(
      name: name,
      message: message,
      id: const Uuid().v4(),
      createdAt: DateTime.now(),
    );
  }

  factory Message.owner(String message) {
    return Message(
      id: '01',
      name: 'Você',
      message: message,
      createdAt: DateTime.now(),
    );
  }

  bool isOwner() => id == '01';

  @override
  String toString() {
    return 'Message(id: $id, message: $message, createdAt: $createdAt)';
  }
}
