import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id;
  String? postImagePath;
  String postContent;
  String postAccountId;
  Timestamp? postTime;

  Post({
    required this.id,
    required this.postImagePath,
    required this.postContent,
    required this.postAccountId,
    required this.postTime,
  });
}
