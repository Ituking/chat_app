import 'dart:math';

import 'package:chat_app/firestore/user_firestore.dart';
import 'package:chat_app/model/talk_room.dart';
import 'package:chat_app/model/user.dart';
import 'package:chat_app/utils/shared_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class RoomFireStore {
  static final FirebaseFirestore _firebaseFirestoreInstance =
      FirebaseFirestore.instance;
  static final _roomCollection = _firebaseFirestoreInstance.collection('room');
  static final joinedRoomSnapshot = _roomCollection
      .where('joined_user_id', arrayContains: SharedPrefs.fetchUid())
      .snapshots();

  static Future<void> createRoom(String myUid) async {
    try {
      final docs = await UserFirestore.fetchUsers();
      if (docs == null) return;
      for (var element in docs) {
        if (element.id == myUid) return;
        await _roomCollection.add({
          'joined_user_id': [element.id, myUid],
          'created_time': Timestamp.now(),
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("FAILED ===== $e");
      }
    }
  }

  static Future<List<TalkRoom>?> fetchJoinedRooms(
      QuerySnapshot snapshot) async {
    try {
      String myUid = SharedPrefs.fetchUid()!;
      List<TalkRoom> talkRooms = [];
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<dynamic> userIds = data['joined_user_id'];
        late String talkUserUid;
        for (var id in userIds) {
          if (id == myUid) continue;
          talkUserUid = id;
        }
        User? talkUser = await UserFirestore.fetchProfile(talkUserUid);
        if (talkUser == null) return null;
        final talkRoom = TalkRoom(
          roomId: doc.id,
          talkUser: talkUser,
          lastMessage: data['last_message'],
        );
        talkRooms.add(talkRoom);
      }
      if (kDebugMode) {
        print(talkRooms.length);
      }
      return talkRooms;
    } catch ($e) {
      if (kDebugMode) {
        print("FAILED ===== $e");
      }
    }
    return null;
  }

  static Stream<QuerySnapshot> fetchMessageSnapshot(String roomId) {
    return _roomCollection
        .doc(roomId)
        .collection('message')
        .orderBy('send_time', descending: true)
        .snapshots();
  }

  static Future<void> sendMessage(
      {required String roomId, required String message}) async {
    try {
      final messageCollection =
          _roomCollection.doc(roomId).collection('message');
      await messageCollection.add({
        'message': message,
        'sender_id': SharedPrefs.fetchUid(),
      });
    } catch ($e) {
      if (kDebugMode) {
        print("FAILED ===== $e");
      }
    }
  }
}
