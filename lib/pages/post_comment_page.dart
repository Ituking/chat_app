import 'package:chat_app/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class PostCommentPage extends StatefulWidget {
  const PostCommentPage({super.key});

  @override
  State<PostCommentPage> createState() => _PostCommentPageState();
}

class _PostCommentPageState extends State<PostCommentPage> {
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
