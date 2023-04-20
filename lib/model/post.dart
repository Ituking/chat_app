import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id;
  String? imagePath;
  String content;
  String postAccountId;
  Timestamp? postTime;

  Post({
    required this.id,
    required this.imagePath,
    required this.content,
    required this.postAccountId,
    required this.postTime,
  });
}
