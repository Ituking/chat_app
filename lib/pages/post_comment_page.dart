import 'package:chat_app/model/comment.dart';
import 'package:chat_app/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class PostCommentPage extends StatefulWidget {
  const PostCommentPage({super.key});

  @override
  State<PostCommentPage> createState() => _PostCommentPageState();
}

class _PostCommentPageState extends State<PostCommentPage> {
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
      body: const Center(
        child: Text("Comment"),
      ),
    );
  }
}
