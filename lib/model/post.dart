import 'package:chat_app/model/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? id;
  String? postImagePath;
  String postContent;
  String postAccountId;
  Account? postAccount;
  Timestamp? postTime;

  Post({
    required this.id,
    required this.postImagePath,
    required this.postContent,
    required this.postAccountId,
    required this.postAccount,
    required this.postTime,
  });
}
