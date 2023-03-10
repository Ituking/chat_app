import 'package:chat_app/firestore/user_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomFireStore {
  static final FirebaseFirestore _firebaseFirestoreInstance =
      FirebaseFirestore.instance;
  static final _roomCollection = _firebaseFirestoreInstance.collection('room');

  static Future<void> createRoom() async {
    final docs = await UserFirestore.fetchUsers();
    try {} catch (e) {}
  }
}
