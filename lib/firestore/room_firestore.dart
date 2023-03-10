import 'package:chat_app/firestore/user_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomFireStore {
  static final FirebaseFirestore _firebaseFirestoreInstance =
      FirebaseFirestore.instance;
  static final _roomCollection = _firebaseFirestoreInstance.collection('room');

  static Future<void> createRoom(String myUid) async {
    try {
      final docs = await UserFirestore.fetchUsers();
      if (docs == null) return;
      docs.forEach((element) async {
        if (element.id == myUid) return;
        await _roomCollection.add({
          'joined_user_id': [element.id, myUid],
          'created_time': Timestamp.now(),
        });
      });
    } catch (e) {}
  }
}
