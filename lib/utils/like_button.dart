import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.thumb_up,
        color: isLiked ? Colors.teal : Colors.grey,
      ),
      onPressed: () {
        setState(() {
          isLiked = !isLiked;
        });
      },
    );
  }
}