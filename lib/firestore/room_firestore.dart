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

  static Future<void> fetchJoinedRooms() async {
    try {
      String myUid = SharedPrefs.fetchUid()!;
      final snapshot = await _roomCollection
          .where('joined_user_id', arrayContains: myUid)
          .get();
      List<TalkRoom> talkRooms = [];
      for (var doc in snapshot.docs) {
        List<dynamic> userIds = doc.data()['joined_user_id'];
        late String talkUserUid;
        for (var id in userIds) {
          if (id == myUid) continue;
          talkUserUid = id;
        }
        User? talkUser = await UserFirestore.fetchProfile(talkUserUid);
        if (talkUser == null) return;
        final talkRoom = TalkRoom(
          roomId: doc.id,
          talkUser: talkUser,
          lastMessage: doc.data()['last_message'],
        );
        talkRooms.add(talkRoom);
      }
      if (kDebugMode) {
        print(talkRooms.length);
      }
    } catch ($e) {
      if (kDebugMode) {
        print("FAILED ===== $e");
      }
    }
  }
}
