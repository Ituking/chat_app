import 'package:chat_app/model/account.dart';
import 'package:chat_app/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AccountFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference account =
      _firestoreInstance.collection('account');

  static Future<dynamic> setUser(Account newAccount) async {
    try {
      await account.doc(newAccount.id).set({
        'name': newAccount.name,
        'user_id': newAccount.userId,
        'self_introduction': newAccount.selfIntroduction,
        'image_path': newAccount.imagePath,
        'created_time': Timestamp.now(),
        'updated_time': Timestamp.now(),
      });
      if (kDebugMode) {
        print("Account registration completed.");
      }
      return true;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Account Registration Failed. $e");
      }
      return false;
    }
  }

  static Future<dynamic> getUser(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await account.doc(uid).get();
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      Account myAccount = Account(
        id: uid,
        name: data['name'],
        imagePath: data['image_path'],
        selfIntroduction: data['self_introduction'],
        userId: data['user_id'],
        createdTime: data['created_time'],
        updatedTime: data['updated_time'],
      );
      Authentication.myAccount = myAccount;
      if (kDebugMode) {
        print("User acquisition succeeded.");
      }
      return true;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("User acquisition failed. $e");
      }
      return false;
    }
  }

  static Future<dynamic> updateUser(Account updateAccount) async {
    try {
      await account.doc(updateAccount.id).update({
        'name': updateAccount.name,
        'image_path': updateAccount.imagePath,
        'user_id': updateAccount.userId,
        'self_introduction': updateAccount.selfIntroduction,
        'update_time': Timestamp.now(),
      });
      if (kDebugMode) {
        print("User information updated successfully.");
      }
    } on FirebaseException catch (e) {}
  }
}
