import 'package:chat_app/model/account.dart';
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
    } on FirebaseException catch (e) {}
  }
}
