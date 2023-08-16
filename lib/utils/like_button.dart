import 'package:chat_app/model/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final Post post;
  const LikeButton({super.key, required this.post});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.post.likedUserIds.contains(widget.post.postAccountId);
  }

  void toggleLike() async {
    setState(() {
      List<String> updatedLikedUserIds = List.from(widget.post.likedUserIds);
      if (kDebugMode) {
        print("postAccountId: ${widget.post.postAccountId}");
        print("likedUserIds: ${widget.post.likedUserIds}");
      }
      if (isLiked) {
        widget.post.likedUserIds.remove(widget.post.postAccountId);
        widget.post.likedCount--;
      } else {
        widget.post.likedUserIds.add(widget.post.postAccountId);
        widget.post.likedCount++;
      }
      widget.post.likedCount = widget.post.likedUserIds.length;
      if (kDebugMode) {
        print("updatedLikedUserIds: $updatedLikedUserIds");
        print("widget.post.likedUserIds: ${widget.post.likedUserIds}");
      }
      isLiked = !isLiked;
    });

    try {
      final ref =
          FirebaseFirestore.instance.collection('posts').doc(widget.post.id);

      final updateData = {
        'liked_count': FieldValue.increment(isLiked ? -1 : 1),
        'liked_user_ids': widget.post.likedUserIds,
      };

      await ref.update(updateData);
      if (kDebugMode) {
        print("Firestore data updated successfully");
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Firestore update error: $e");
      }
    }
  }

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
