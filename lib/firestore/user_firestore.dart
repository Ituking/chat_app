import 'package:chat_app/firestore/room_firestore.dart';
import 'package:chat_app/model/user.dart';
import 'package:chat_app/utils/shared_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserFirestore {
  static final FirebaseFirestore _firebaseFirestoreInstance =
      FirebaseFirestore.instance;
  static final _userCollection = _firebaseFirestoreInstance.collection('user');

  static Future<String?> insertNewAccount() async {
    try {
      final newDoc = await _userCollection.add({
        'name': "Noname",
        'image_path':
            "https://images.unsplash.com/photo-1472396961693-142e6e269027?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxNTgwfDB8MXxzZWFyY2h8Mjl8fE5hdHVyZXxlbnwwfHx8fDE2NzgwODY0NTY&ixlib=rb-4.0.3&q=80&w=400",
      });
      if (kDebugMode) {
        print("SUCCESS");
        return newDoc.id;
      }
    } catch (e) {
      if (kDebugMode) {
        print("FAILED ===== $e");
        return null;
      }
    }
    return null;
  }

  static Future<void> createUser() async {
    final myUid = await UserFirestore.insertNewAccount();
    if (myUid != null) {
      await RoomFireStore.createRoom(myUid);
      await SharedPrefs.setUid(myUid);
    }
  }

  static Future<List<QueryDocumentSnapshot>?> fetchUsers() async {
    try {
      final snapshot = await _userCollection.get();

      return snapshot.docs;
    } catch (e) {
      if (kDebugMode) {
        print("FAILED ===== $e");
      }
      return null;
    }
  }

  static Future<User?> fetchMyProfile() async {
    try {
      String uid = SharedPrefs.fetchUid()!;
      final myProfile = await _userCollection.doc(uid).get();
      User user = User(
        name: myProfile.data()!['name'],
        imagePath: myProfile.data()!['image_path'],
        uid: uid,
      );

      return user;
    } catch (e) {}
  }
}
