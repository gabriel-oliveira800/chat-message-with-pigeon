import 'package:flutter/services.dart';

import '../dtos/message.dart';

abstract class MessageService {
  static const _channel = MethodChannel('cubos.dev.message/service');

  static Future<Messages> getMessages() async {
    final messages = await _channel.invokeMethod<List>('getMessages');
    if (messages == null) return [];

    return messages.map((it) {
      final isOwner = (it as String).contains('[OWNER]: ');
      final message = it.replaceAll(RegExp(r'\[OWNER\]: '), '');

      if (isOwner) return Message.owner(message);
      return Message.generateId(message, 'John Doe');
    }).toList();
  }

  static Future<Message?> sendMessage(Message message) async {
    final result = await _channel.invokeMethod<Map>('sendMessage');
    if (result == null) return null;

    return Message.generateId(result['message'], result['name']);
  }
}
