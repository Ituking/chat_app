import 'package:chat_app/firestore/post_firestore.dart';
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

  static Future<dynamic> getMyAccount(String uid) async {
    try {
      if (kDebugMode) {
        print("uid => $uid");
      }
      DocumentSnapshot documentSnapshot = await account.doc(uid).get();
      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;
        if (data != null) {
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
        } else {
          if (kDebugMode) {
            print("User data is null.");
          }
          return false;
        }
      } else {
        if (kDebugMode) {
          print("User document does not exist.");
        }
        return false;
      }
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
      return true;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed to update user information. $e");
      }
      return true;
    }
  }

  static Future<Map<String, Account>?> getPostUserMap(
      List<String> accountIds) async {
    Map<String, Account> map = {};
    try {
      await Future.forEach(accountIds, (String accountId) async {
        var doc = await account.doc(accountId).get();
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Account postAccount = Account(
          id: accountId,
          name: data['name'],
          imagePath: data['image_path'],
          selfIntroduction: data['self_introduction'],
          userId: data['user_id'],
        );
        map[accountId] = postAccount;
      });
      if (kDebugMode) {
        print(
            "Successful acquisition of information about the user who submitted the article.");
      }
      return map;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failure to obtain information about the submitting user. $e");
      }
      return null;
    }
  }

  static Future<dynamic> deleteUser(String accountId) async {
    account.doc(accountId).delete();
    PostFirestore.deletePosts(accountId);
  }

  static Future<dynamic> getUser(String uid) async {}
}
