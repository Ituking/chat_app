import 'package:chat_app/model/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final Post post;
  const LikeButton({super.key, required this.post});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false;

  void toggleLike() {
    setState(() {
      List<String> updatedLikedUserIds = List.from(widget.post.likedUserIds);
      if (isLiked) {
        widget.post.likedUserIds.remove(widget.post.postAccountId);
        widget.post.likedCount--;
      } else {
        widget.post.likedUserIds.add(widget.post.postAccountId);
        widget.post.likedCount++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.thumb_up_outlined,
        color: isLiked
            ? const Color.fromRGBO(255, 100, 130, 1)
            : CupertinoColors.black,
      ),
      onPressed: () {
        setState(
          () {
            isLiked = !isLiked;
          },
        );
      },
    );
  }
}
