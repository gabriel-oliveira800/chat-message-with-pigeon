import 'package:flutter/material.dart';

import '../../dtos/message.dart';
import 'message_bubble.dart';

class MessagesWrapper extends StatelessWidget {
  final bool isLoading;
  final Messages messages;
  final ScrollController scrollController;

  const MessagesWrapper({
    super.key,
    required this.messages,
    required this.isLoading,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isLoading,
      replacement: const Center(
        child: CircularProgressIndicator(),
      ),
      child: ListView.builder(
        itemCount: messages.length,
        controller: scrollController,
        padding: const EdgeInsets.only(bottom: 60),
        itemBuilder: (context, index) => MessageBubble(data: messages[index]),
      ),
    );
  }
}
