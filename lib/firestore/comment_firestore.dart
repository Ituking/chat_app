import 'package:chat_app/model/account.dart';
import 'package:chat_app/model/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CommentFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference comments =
      _firestoreInstance.collection('comments');
  static final CollectionReference account =
      _firestoreInstance.collection('account');

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

  static Future<Map<String, Account>?> getCommentUserMap(
      List<String> accountIds) async {
    Map<String, Account> map = {};
    try {
      await Future.forEach(accountIds, (String accountId) async {
        var doc = await account.doc(accountId).get();

        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          if (kDebugMode) {
            print(data);
            print(data['name']);
            print(data['image_path']);
            print(data['self_introduction']);
            print(data['user_id']);
          }
          Account commentAccount = Account(
            id: accountId,
            name: data['name'].toString(),
            profileImagePath: data['image_path'].toString(),
            selfIntroduction: data['self_introduction'].toString(),
            userId: data['user_id'].toString(),
          );
          map[accountId] = commentAccount;
          if (kDebugMode) {
            print("accountid => $accountId");
          }
          if (kDebugMode) {
            print("commentAccountId => {$commentAccount.id}");
          }
          if (kDebugMode) {
            print("map => $map");
          }
        } else {
          // ドキュメントが存在しない場合のエラーハンドリング
          if (kDebugMode) {
            print('Document does not exist for account ID: $accountId');
          }
        }
      });
      if (kDebugMode) {
        print('Completed acquisition of comment user information.');
      }
      return map;
    } on FirebaseException catch (e) {
      // Firebaseからのエラーが発生した場合のエラーハンドリング
      if (kDebugMode) {
        print('Failure to obtain comment user information: $e');
      }
      return null;
    } catch (e) {
      // その他のエラーが発生した場合のエラーハンドリング
      if (kDebugMode) {
        print('An error occurred while obtaining comment user information: $e');
      }
      return null;
    }
  }
}
