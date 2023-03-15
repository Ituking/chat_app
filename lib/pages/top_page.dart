import 'package:chat_app/firestore/room_firestore.dart';
import 'package:chat_app/model/user.dart';
import 'package:chat_app/pages/setting_profile_page.dart';
import 'package:chat_app/pages/talk_room_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<User> userList = [
    User(
      name: "Emma",
      uid: "0001",
      imagePath:
          "https://images.unsplash.com/photo-1472396961693-142e6e269027?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxNTgwfDB8MXxzZWFyY2h8Mjl8fE5hdHVyZXxlbnwwfHx8fDE2NzgwODY0NTY&ixlib=rb-4.0.3&q=80&w=400",
    ),
    User(
      name: "John",
      uid: "0002",
    ),
    User(
      name: "Michael",
      uid: "0003",
      imagePath:
          "https://images.unsplash.com/photo-1472396961693-142e6e269027?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxNTgwfDB8MXxzZWFyY2h8Mjl8fE5hdHVyZXxlbnwwfHx8fDE2NzgwODY0NTY&ixlib=rb-4.0.3&q=80&w=400",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChatApp"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingProfilePage(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: RoomFireStore.joinedRoomSnapshot,
          builder: (context, streamSnapshot) {
            if (streamSnapshot.hasData) {
              return FutureBuilder(
                  future: RoomFireStore.fetchJoinedRooms(streamSnapshot.data!),
                  builder: (context, futureSnapshot) {
                    if (futureSnapshot.hasData) {
                      return ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TalkRoomPage(
                                      name: userList[index].name,
                                    ),
                                  ),
                                );
                              },
                              child: SizedBox(
                                height: 70,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            userList[index].imagePath == null
                                                ? null
                                                : NetworkImage(
                                                    userList[index].imagePath!),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          userList[index].name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text(
                                          "Hello.",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  });
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
