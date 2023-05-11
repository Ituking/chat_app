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

  static Future<List<Comment>> getCommentsFromIds(List<String> ids) async {
    List<Post> postList = [];
    try {
      await Future.forEach(ids, (id) async {
        var doc = await comments.doc(id).get();
      });
    } on FirebaseException catch (e) {}
  }
}
