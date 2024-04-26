import '../../api/messages.g.dart';
import '../dtos/message.dart';

import 'utils.dart';

class NativeMessageApi implements FlutterMessagingApi {
  final MessagingApi _nativeAPI = MessagingApi();

  NativeMessageApi() {
    FlutterMessagingApi.setUp(this);
  }

  @override
  Future<List<MessageDto?>> getMessages() async {
    return await _nativeAPI.getMessages();
  }

  @override
  Future<MessageDto> sendMessage(MessageDto message) async {
    return await _nativeAPI.sendMessage(message);
  }
}

abstract class MessageService {
  static final _api = NativeMessageApi();

  static Future<Messages> getMessages() async {
    final messages = await _api.getMessages();
    return messages.map((it) => Utils.convertToMessage(it!)).toList();
  }

  static Future<Message?> sendMessage(Message message) async {
    final response = await _api.sendMessage(Utils.convertToMessageDto(message));

    return Utils.convertToMessage(response);
  }
}
