import 'package:chat_app/model/post.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      post.postImagePath!,
      fit: BoxFit.cover,
    );
  }
}
