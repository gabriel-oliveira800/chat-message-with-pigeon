import '../../api/messages.g.dart';
import '../dtos/message.dart';

import 'utils.dart';

abstract class MessageService {
  static final _api = MessagingApi();

  static Future<Messages> getMessages() async {
    final messages = await _api.getMessages();
    return messages.map((it) => Utils.convertToMessage(it!)).toList();
  }

  static Future<Message?> sendMessage(Message message) async {
    final response = await _api.sendMessage(Utils.convertToMessageDto(message));

    return Utils.convertToMessage(response);
  }
}
