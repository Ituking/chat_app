import 'package:flutter/material.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onSend;
  const ChatInputField({super.key, this.controller, this.onSend});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
