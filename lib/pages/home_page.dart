import 'package:chat_app/model/post.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> userPosts = [
    Post(
      id: "0001",
      postAccountId: "0001",
      postTime: DateTime.now(),
      imagePath:
          "https://images.unsplash.com/photo-1471922694854-ff1b63b20054?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1472&q=80",
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                CircleAvatar(
                  radius: 22,
                  foregroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1471922694854-ff1b63b20054?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1472&q=80",
                  ),
                ),
                Text("Emma"),
              ],
            ),
          ),
          Container(
            height: 400,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
