import '../../api/messages.g.dart';
import '../dtos/message.dart';

abstract class Utils {
  static Message convertToMessage(MessageDto message) {
    return Message(
      id: message.id,
      name: message.name,
      message: message.message,
      createdAt: DateTime.tryParse(message.createdAt) ?? DateTime.now(),
    );
  }

  static MessageDto convertToMessageDto(Message message) {
    return MessageDto(
      id: message.id,
      name: message.name,
      message: message.message,
      createdAt: message.createdAt.toIso8601String(),
    );
  }
}
