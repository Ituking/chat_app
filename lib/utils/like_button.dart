import 'package:chat_app/model/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final Post post;
  const LikeButton({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.favorite,
        color: isLiked
            ? const Color.fromRGBO(255, 100, 130, 1)
            : CupertinoColors.systemGrey,
      ),
      onPressed: toggleLike,
    );
  }
}
