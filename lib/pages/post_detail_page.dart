import 'package:chat_app/model/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;
  const PostDetailPage({super.key, required this.post});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.white,
        elevation: 0,
        title: const Text(
          "Post",
          style: TextStyle(
            color: CupertinoColors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Hero(
        tag: "post_${widget.post.id}",
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.post.imagePath!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
