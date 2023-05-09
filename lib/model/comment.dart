import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String id;
  String content;
  String commentAccountId;
  Timestamp? commentTime;

  Comment({
    required this.id,
    required this.content,
    required this.commentAccountId,
    required this.commentTime,
  });
}
