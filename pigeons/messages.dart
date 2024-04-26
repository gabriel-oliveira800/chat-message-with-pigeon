import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  debugGenerators: true,
  input: 'pigeons/messages.dart',
  dartOut: 'lib/api/messages.g.dart',
  swiftOut: 'ios/Runner/Messages.g.swift',
  cppHeaderOut: 'windows/runner/messages.g.h',
  cppSourceOut: 'windows/runner/messages.g.cpp',
  javaOut: 'android/app/src/main/java/com/example/messages/Messages.java',
  kotlinOut: 'android/app/src/main/kotlin/com/example/messages/Messages.kt',
  objcHeaderOut: 'macos/Runner/messages.g.h',
  objcSourceOut: 'macos/Runner/messages.g.m',
))

/// MessagingApi
@HostApi()
abstract class MessagingApi {
  List<MessageDto> getMessages();
  MessageDto sendMessage(MessageDto message);
}

@FlutterApi()
abstract class FlutterMessagingApi {
  @async
  List<MessageDto> getMessages();

  @async
  MessageDto sendMessage(MessageDto message);
}

class MessageDto {
  final String id;
  final String name;
  final String message;
  final String createdAt;

  const MessageDto({
    required this.id,
    required this.name,
    required this.message,
    required this.createdAt,
  });
}
