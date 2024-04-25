import 'package:rubik_utils/rubik_utils.dart';

import 'package:flutter/material.dart';

import '../../dtos/message.dart';

class MessageBubble extends StatelessWidget {
  final Message data;
  const MessageBubble({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final bool isOwner = data.isOwner();
    final screenWidth = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: isOwner ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: isOwner ? Colors.deepPurpleAccent : Colors.grey[300],
          ),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: Column(
            crossAxisAlignment: data.isOwner()
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              _title(isOwner),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenWidth.width * 0.8,
                ),
                child: Text(
                  data.message,
                  style: TextStyle(
                    color: isOwner ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(bool isOwner) {
    final textColor = isOwner ? Colors.white : Colors.black;

    return RichText(
      text: TextSpan(
        text: data.name,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: ' às ${data.createdAt.toTimeStr()}',
            style: TextStyle(
              fontSize: 12,
              color: textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
