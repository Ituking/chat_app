import 'package:chat_app/model/account.dart';
import 'package:chat_app/model/comment.dart';
import 'package:chat_app/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class PostCommentPage extends StatefulWidget {
  const PostCommentPage({super.key});

  @override
  State<PostCommentPage> createState() => _PostCommentPageState();
}

class _PostCommentPageState extends State<PostCommentPage> {
  Account commentAccount = Account(
    id: "1",
    name: "Emma",
    imagePath:
        "https://images.unsplash.com/photo-1472396961693-142e6e269027?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxNTgwfDB8MXxzZWFyY2h8Mjl8fE5hdHVyZXxlbnwwfHx8fDE2NzgwODY0NTY&ixlib=rb-4.0.3&q=80&w=400",
    selfIntroduction:
        "Hi everyone! I'm Emma. I'm passionate about Programming, and love sharing my experiences and thoughts with others.",
    userId: "0001",
  );

  List<Comment> commentList = [
    Comment(
      id: "1",
      content: "Beautiful photo! You're such a talented photographer.",
      commentAccountId: "1",
      commentTime: DateTime.now(),
    ),
    Comment(
      id: "2",
      content: "This place looks amazing! I need to add it to my travel list.",
      commentAccountId: "2",
      commentTime: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.createAppBar("Comment"),
      body: ListView.builder(
        itemCount: commentList.length,
        itemBuilder: (context, index) {},
      ),
    );
  }
}
