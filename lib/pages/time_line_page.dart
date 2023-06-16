import 'package:chat_app/model/post.dart';
import 'package:chat_app/post_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: CupertinoSearchTextField(
            placeholder: 'Search',
            onSubmitted: (String value) {},
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
