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
      backgroundColor: const Color.fromARGB(236, 255, 255, 255),
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListView.builder(
                physics: const RangeMaintainingScrollPhysics(),
                shrinkWrap: true,
                reverse: true,
                itemCount: messageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                        bottom: index == 0 ? 10 : 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      textDirection: messageList[index].isMe
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.6),
                          decoration: BoxDecoration(
                            color: messageList[index].isMe
                                ? const Color.fromARGB(194, 158, 158, 158)
                                : const Color.fromARGB(255, 12, 151, 107),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          child: Text(
                            messageList[index].message,
                            style: TextStyle(
                              color: messageList[index].isMe
                                  ? Colors.black
                                  : const Color.fromARGB(230, 255, 255, 255),
                            ),
                          ),
                        ),
                        Text(intl.DateFormat('HH:mm')
                            .format(messageList[index].sendTime)),
                      ],
                    ),
                  );
                }),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.white,
                  height: 60,
                ),
                Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).padding.bottom,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
