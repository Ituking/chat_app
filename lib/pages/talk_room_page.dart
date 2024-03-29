import 'package:chat_app/firestore/room_firestore.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/talk_room.dart';
import 'package:chat_app/pages/user_profile_page.dart';
import 'package:chat_app/utils/shared_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
      backgroundColor: CupertinoColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: CupertinoColors.black,
        ),
        centerTitle: false,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (contaxt) => UserProfilePage(
                      userId: widget.talkRoom.talkUser.uid,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.talkRoom.talkUser.imagePath!,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              widget.talkRoom.talkUser.name,
              style: const TextStyle(
                color: CupertinoColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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
                                          ? CupertinoColors.activeGreen
                                          : CupertinoColors.inactiveGray,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            message.message,
                                            style: const TextStyle(
                                              color: CupertinoColors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          intl.DateFormat('HH:mm').format(
                                            message.sendTime.toDate(),
                                          ),
                                          style: const TextStyle(
                                            color: CupertinoColors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
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
                  color: CupertinoColors.white,
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 0,
                                color: CupertinoColors.inactiveGray,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CupertinoTextField(
                                cursorColor: CupertinoColors.activeGreen,
                                controller: controller,
                                decoration: BoxDecoration(
                                  color:
                                      CupertinoColors.extraLightBackgroundGray,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                placeholder: 'Enter a message',
                                placeholderStyle: const TextStyle(
                                  color: CupertinoColors.secondaryLabel,
                                ),
                                style: const TextStyle(
                                  color: CupertinoColors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () async {
                          await RoomFireStore.sendMessage(
                            roomId: widget.talkRoom.roomId,
                            message: controller.text,
                          );
                          controller.clear();
                        },
                        child: const Icon(
                          CupertinoIcons.paperplane,
                          color: CupertinoColors.activeGreen,
                        ),
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
