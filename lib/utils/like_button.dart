import 'package:chat_app/model/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final Post post;
  final bool isLiked;
  final VoidCallback onPressed;
  const LikeButton(
      {super.key,
      required this.post,
      required this.isLiked,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.favorite,
        color: isLiked
            ? const Color.fromRGBO(255, 100, 130, 1)
            : CupertinoColors.systemGrey,
      ),
      onPressed: onPressed,
    );
  }
}
