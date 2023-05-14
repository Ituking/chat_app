import 'package:chat_app/model/account.dart';
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
    List<Comment> commentList = [];
  }

  static Future<Map<String, Account>?> getCommentUserMap(
      List<String> accountIds) async {
    Map<String, Account> map = {};
    try {
      await Future.forEach(accountIds, (String accountId) async {
        var doc = await comments.doc(accountId).get();
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Account commentAccount = Account(
          id: accountId,
          name: data['name'],
          imagePath: data['image_path'],
          selfIntroduction: data['self_introduction'],
          userId: data['user_id'],
        );
        map[accountId] = commentAccount;
        if (kDebugMode) {
          print("Completed acquisition of comment user information.");
        }
        return map;
      });
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failure to obtain comment user information. $e");
      }
      return null;
    }
    return null;
  }
}
