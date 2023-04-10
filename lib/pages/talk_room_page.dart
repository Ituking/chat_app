import 'package:chat_app/firestore/room_firestore.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/talk_room.dart';
import 'package:chat_app/utils/shared_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class TalkRoomPage extends StatefulWidget {
  final TalkRoom talkRoom;
  const TalkRoomPage({super.key, required this.talkRoom});

  @override
  State<TalkRoomPage> createState() => _TalkRoomPageState();
}

class _TalkRoomPageState extends State<TalkRoomPage> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(236, 255, 255, 255),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          widget.talkRoom.talkUser.name,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream:
                    RoomFireStore.fetchMessageSnapshot(widget.talkRoom.roomId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: ListView.builder(
                          physics: const RangeMaintainingScrollPhysics(),
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final doc = snapshot.data!.docs[index];
                            final Map<String, dynamic> data =
                                doc.data() as Map<String, dynamic>;
                            final Message message = Message(
                              message: data['message'],
                              isMe: SharedPrefs.fetchUid() == data['sender_id'],
                              sendTime: data['send_time'],
                            );
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: 10,
                                  left: 10,
                                  right: 10,
                                  bottom: index == 0 ? 10 : 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                textDirection: message.isMe
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.6),
                                    decoration: BoxDecoration(
                                      color: message.isMe
                                          ? Colors.blueGrey
                                          : Colors.green,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    child: Text(
                                      message.message,
                                      style: TextStyle(
                                        color: message.isMe
                                            ? Colors.white
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    intl.DateFormat('HH:mm').format(
                                      message.sendTime.toDate(),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  } else {
                    return const Center(
                      child: Text("NO MESSAGE"),
                    );
                  }
                }),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: Colors.white,
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: controller,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await RoomFireStore.sendMessage(
                            roomId: widget.talkRoom.roomId,
                            message: controller.text,
                          );
                          controller.clear();
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).padding.bottom * 0.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
