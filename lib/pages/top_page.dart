import 'package:chat_app/firestore/room_firestore.dart';
import 'package:chat_app/model/talk_room.dart';
import 'package:chat_app/pages/talk_room_page.dart';
import 'package:chat_app/utils/widget_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.createAppBar("Chats"),
      body: StreamBuilder<QuerySnapshot>(
        stream: RoomFireStore.joinedRoomSnapshot,
        builder: (context, streamSnapshot) {
          if (streamSnapshot.hasData) {
            return FutureBuilder<List<TalkRoom>?>(
                future: RoomFireStore.fetchJoinedRooms(streamSnapshot.data!),
                builder: (context, futureSnapshot) {
                  if (futureSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  } else {
                    if (futureSnapshot.hasData) {
                      List<TalkRoom> talkRooms = futureSnapshot.data!;
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            itemCount: talkRooms.length,
                            itemBuilder: (context, index) {
                              if (kDebugMode) {
                                print(
                                  "talkRooms[index].talkUser.imagePath => ${talkRooms[index].talkUser.imagePath}",
                                );
                              }
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TalkRoomPage(
                                        talkRoom: talkRooms[index],
                                      ),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height: 70,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          16.0,
                                          0,
                                          8.0,
                                          0,
                                        ),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundImage: talkRooms[index]
                                                      .talkUser
                                                      .imagePath !=
                                                  null
                                              ? NetworkImage(talkRooms[index]
                                                  .talkUser
                                                  .imagePath!)
                                              : null,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              talkRooms[index].talkUser.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              talkRooms[index].lastMessage ??
                                                  "",
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    } else {
                      return const Center(
                        child: Text("FAILED"),
                      );
                    }
                  }
                });
          } else {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
    );
  }
}
