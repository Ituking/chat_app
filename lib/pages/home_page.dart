import 'package:chat_app/main.dart';
import 'package:chat_app/model/post.dart';
import 'package:chat_app/model/user.dart';
import 'package:chat_app/pages/post_page.dart';
import 'package:chat_app/utils/widget_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> postedUser = [
    User(
      name: "Emma",
      uid: "0001",
    ),
    User(
      name: "John",
      uid: "0002",
    ),
    User(
      name: "Mark",
      uid: "0003",
    ),
    User(
      name: "Stefan",
      uid: "0004",
    ),
  ];
  List<Post> userPostsList = [
    Post(
      id: "0001",
      postAccountId: "0001",
      postTime: Timestamp.now(),
      imagePath:
          "https://images.unsplash.com/photo-1471922694854-ff1b63b20054?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1472&q=80",
      content: 'On a sunny day, you can still go to the beach 🌊.',
    ),
    Post(
      id: "0002",
      postAccountId: "0002",
      postTime: Timestamp.now(),
      imagePath:
          "https://images.unsplash.com/photo-1542233637-20456b09d882?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
      content: 'A day healed by nature 🌳.',
    ),
    Post(
      id: "0003",
      postAccountId: "0003",
      postTime: Timestamp.now(),
      imagePath: "https://cdn.pixabay.com/photo/2010/11/26/canyon-203_1280.jpg",
      content: 'Lovely views taken on my trip ✨.',
    ),
    Post(
      id: "0004",
      postAccountId: "0004",
      postTime: Timestamp.now(),
      imagePath:
          "https://images.unsplash.com/photo-1544005313-94ddf0286df2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxNTgwfDB8MXxzZWFyY2h8M3x8cGVyc29ufGVufDB8fHx8MTY4MTM4NjM2MQ&ixlib=rb-4.0.3&q=80&w=400",
      content: 'Great walk on a sunny day.',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.createAppBar("Home"),
      body: ListView.builder(
        itemCount: userPostsList.length,
        itemBuilder: (context, index) {
          final post = userPostsList[index];
          final user =
              postedUser.firstWhere((user) => user.uid == post.postAccountId);
          final formattedDate = DateFormat('EEE MMM dd yyyy HH:mm').format(
            post.postTime!.toDate(),
          );
          return Card(
            child: SizedBox(
              height: 350,
              child: Column(
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1472396961693-142e6e269027?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxNTgwfDB8MXxzZWFyY2h8Mjl8fE5hdHVyZXxlbnwwfHx8fDE2NzgwODY0NTY&ixlib=rb-4.0.3&q=80&w=400",
                      ),
                    ),
                    title: Text(
                      user.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      formattedDate,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        image: DecorationImage(
                          image: NetworkImage(
                            post.imagePath!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.thumb_up,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            "Like",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.comment,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            "Comments",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.share,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            "Share",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: materialWhite,
        foregroundColor: Colors.black,
        onPressed: () => showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: const PostPage(),
                ),
              ),
            );
          },
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
