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
      appBar: AppBar(
        elevation: 0,
      ),
      body: const Center(
        child: Text("Comment"),
      ),
    );
  }
}
