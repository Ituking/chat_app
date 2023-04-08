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
  List<Post> userPosts = [
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
      body: Column(
        children: [
          SizedBox(
            height: 350,
            child: Column(
              children: [
                const ListTile(
                  leading: CircleAvatar(),
                  title: Text("Emma"),
                  subtitle: Text("Tue Oct 01 2022 12:40"),
                ),
                Expanded(
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.thumb_up),
                        Text("Like"),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(Icons.comment),
                        Text("Comments"),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(Icons.share),
                        Text("Share"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
