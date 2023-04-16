import 'package:chat_app/model/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference account =
      _firestoreInstance.collection('account');

  static Future<dynamic> setUser(Account newAccount) async {}
}
