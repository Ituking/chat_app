import 'package:chat_app/model/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference comments =
      _firestoreInstance.collection('comments');

  static Future<dynamic> addComment(Comment newComment) async {
    try {} on FirebaseException catch (e) {}
  }
}
