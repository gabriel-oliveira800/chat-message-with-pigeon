import 'dart:math';

import 'package:flutter/material.dart';

import '../services/message_service.dart';
import '../dtos/message.dart';

import 'components/messages_wrapper.dart';
import 'components/custom_app_bar.dart';
import 'components/send_message.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Messages _messages = <Message>[];

  late final FocusNode _focusNode;
  late final ScrollController _scrollController;
  late final TextEditingController _textController;

  bool _isLoading = false;

  void _toggle([Messages? data]) {
    setState(() {
      _isLoading = !_isLoading;
      if (data != null) _messages.addAll(data);
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _scrollController = ScrollController();
    _textController = TextEditingController();

    Future(_getAllMessages);
  }

  Future<void> _getAllMessages() async {
    _toggle();
    final result = await MessageService.getMessages();
    _toggle(result);
  }

  void _clearMessages() => setState(_messages.clear);

  void _addMessage() async {
    final data = Message.owner(_textController.text);

    setState(() => _messages.add(data));
    _textController.clear();

    final duration = Random().nextInt(500);
    Future.delayed(Duration(milliseconds: duration), () async {
      final result = await MessageService.sendMessage(data);
      if (result != null) setState(() => _messages.add(result));

      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      curve: Curves.linear,
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onClear: _clearMessages,
        onRefresh: _messages.isEmpty ? _getAllMessages : null,
      ),
      body: MessagesWrapper(
        messages: _messages,
        isLoading: _isLoading,
        scrollController: _scrollController,
      ),
      bottomSheet: SendMessage(
        onSend: _addMessage,
        focusNode: _focusNode,
        onTap: _scrollToBottom,
        textController: _textController,
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }
}
