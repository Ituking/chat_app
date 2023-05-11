import 'package:chat_app/model/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CommentFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference comments =
      _firestoreInstance.collection('comments');

  static Future<dynamic> addComment(Comment newComment) async {
    try {
      final CollectionReference userComments = _firestoreInstance
          .collection('user')
          .doc(newComment.commentAccountId)
          .collection('my_comments');
      var result = await comments.add({
        'content': newComment.content,
        'comment_account_id': newComment.commentAccountId,
        'comment_time': Timestamp.now(),
      });
      userComments.doc(result.id).set({
        'comment_id': result.id,
        'comment_time': Timestamp.now(),
      });
      if (kDebugMode) {
        print("Comment Completed.");
      }
      return true;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Comment Failed.$e");
      }
      return false;
    }
  }

  static Future<dynamic> getCommentsFromIds(List<String> ids) async {
    List<Comment> commentList = [];
    try {
      await Future.forEach(ids, (id) async {
        var doc = await comments.doc(id).get();
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Comment comment = Comment(
          id: id,
          content: data["content"],
          commentAccountId: data["comment_account_id"],
          commentTime: data["comment_time"],
        );
        commentList.add(comment);
        if (kDebugMode) {
          print("Comment acquisition completed.");
        }
        return commentList;
      });
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed to get comment.$e");
      }
      return false;
    }
  }
}
