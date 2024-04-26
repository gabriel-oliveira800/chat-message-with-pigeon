import 'package:flutter/material.dart';

class SendMessage extends StatelessWidget {
  final FocusNode focusNode;
  final VoidCallback onSend;
  final TextEditingController textController;

  const SendMessage({
    super.key,
    required this.onSend,
    required this.focusNode,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: Listenable.merge([
        focusNode,
        textController,
      ]),
      builder: (context, child) {
        final isEnable = textController.text.isNotEmpty;
        final border = Border(top: BorderSide(color: Colors.grey[400]!));

        return Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            border: focusNode.hasFocus ? border : null,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  focusNode: focusNode,
                  controller: textController,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Enviar uma mensagem',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              IconButton(
                onPressed: isEnable ? onSend : null,
                icon: Icon(
                  Icons.send,
                  color: !isEnable ? Colors.grey : Colors.purple,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
