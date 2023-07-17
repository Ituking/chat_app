import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  String id;
  String name;
  String profileImagePath;
  String selfIntroduction;
  String userId;
  Timestamp? createdTime;
  Timestamp? updatedTime;

  Account({
    required this.id,
    required this.name,
    required this.profileImagePath,
    required this.selfIntroduction,
    required this.userId,
    this.createdTime,
    this.updatedTime,
  });
}
