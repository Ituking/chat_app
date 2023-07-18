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

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      name: map['name'],
      profileImagePath: map['profileImagePath'],
      selfIntroduction: map['selfIntroduction'],
      userId: map['userId'],
    );
  }
}
