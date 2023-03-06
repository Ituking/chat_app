import 'package:chat_app/model/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

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
      sendTime: DateTime(2023, 3, 6, 12, 16),
    ),
    Message(
      message: "Hello.",
      isMe: false,
      sendTime: DateTime(2023, 3, 6, 10, 58),
    ),
    Message(
      message: "She never gave me their numbers.",
      isMe: true,
      sendTime: DateTime(2023, 3, 6, 08, 02),
    ),
    Message(
      message:
          "Might head out with some friends today will be home late if I do.",
      isMe: false,
      sendTime: DateTime(2023, 3, 6, 07, 23),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: ListView.builder(
          physics: const RangeMaintainingScrollPhysics(),
          shrinkWrap: true,
          reverse: true,
          itemCount: messageList.length,
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              textDirection: messageList[index].isMe
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  decoration: BoxDecoration(
                    color: messageList[index].isMe
                        ? const Color.fromARGB(194, 158, 158, 158)
                        : const Color.fromARGB(255, 14, 229, 161),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Text(messageList[index].message),
                ),
                Text(intl.DateFormat('HH:mm')
                    .format(messageList[index].sendTime)),
              ],
            );
          }),
    );
  }
}
