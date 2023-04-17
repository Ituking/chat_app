import 'package:chat_app/model/post.dart';
import 'package:chat_app/post_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({super.key});

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  List<Post> postList = [
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Timeline",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          if (kDebugMode) {
            print("You Taped.");
          }
        },
        child: GridView.builder(
          padding: const EdgeInsets.all(4),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (BuildContext context, int index) {
            try {
              return PostWidget(post: postList[index]);
            } catch (e) {
              if (e is RangeError) {
                return Container();
              } else {
                rethrow;
              }
            }
          },
        ),
      ),
    );
  }
}
