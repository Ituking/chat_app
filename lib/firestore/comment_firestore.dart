import 'package:chat_app/model/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    } on FirebaseException catch (e) {}
  }
}
