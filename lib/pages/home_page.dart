import 'package:chat_app/model/post.dart';
import 'package:chat_app/model/user.dart';
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
  ];
  List<Post> userPostsList = [
    Post(
      id: "0001",
      postAccountId: "0001",
      postTime: DateTime.now(),
      imagePath:
          "https://images.unsplash.com/photo-1471922694854-ff1b63b20054?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1472&q=80",
    ),
    Post(
      id: "0002",
      postAccountId: "0002",
      postTime: DateTime.now(),
      imagePath:
          "https://images.unsplash.com/photo-1542233637-20456b09d882?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Home"),
      ),
      body: ListView.builder(
        itemCount: userPostsList.length,
        itemBuilder: (context, index) {
          final post = userPostsList[index];
          final user =
              postedUser.firstWhere((user) => user.uid == post.postAccountId);
          final formattedDate =
              DateFormat('EEE MMM dd yyyy HH:mm').format(post.postTime!);
          return Card(
            child: SizedBox(
              height: 350,
              child: Column(
                children: [
                  ListTile(
                    leading: const CircleAvatar(),
                    title: Text(user.name),
                    subtitle: Text(formattedDate),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
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
    );
  }
}
