import 'package:chat_app/model/account.dart';
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
  List<Account> accountList = [];
  List<Post> postList = [
    Post(
      id: '1',
      postImagePath:
          "https://cdn.pixabay.com/photo/2023/05/23/18/12/hummingbird-8013214_1280.jpg",
      postContent: 'This is a demo post 1',
      postAccountId: 'user1',
      postAccount: Account(
        id: 'user1',
        name: 'User 1',
        profileImagePath: '',
        selfIntroduction: '',
        userId: '',
      ),
      postTime: Timestamp.now(),
    ),
    Post(
      id: '2',
      postImagePath:
          "https://cdn.pixabay.com/photo/2023/05/23/18/12/hummingbird-8013214_1280.jpg",
      postContent: 'This is a demo post 2',
      postAccountId: 'user2',
      postAccount: Account(
        id: 'user2',
        name: 'User 2',
        profileImagePath: '',
        selfIntroduction: '',
        userId: '',
      ),
      postTime: Timestamp.now(),
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
