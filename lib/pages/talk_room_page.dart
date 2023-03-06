import 'package:chat_app/model/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TalkRoomPage extends StatefulWidget {
  final String name;
  const TalkRoomPage({super.key, required this.name});

  @override
  State<TalkRoomPage> createState() => _TalkRoomPageState();
}

class _TalkRoomPageState extends State<TalkRoomPage> {
  List<Message> messageList = [
    Message(
      message: "Hello.",
      isMe: true,
      sendTime: DateTime(2023, 3, 6, 10, 58),
    ),
    Message(
      message: "Hello.",
      isMe: false,
      sendTime: DateTime(2023, 3, 6, 12, 24),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: ListView.builder(
          itemCount: messageList.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Text(messageList[index].message),
                Text(DateFormat('HH:mm').format(messageList[index].sendTime)),
              ],
            );
          }),
    );
  }
}
