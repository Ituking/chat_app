import 'package:cloud_firestore/cloud_firestore.dart';

class PostFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference posts =
      _firestoreInstance.collection('posts');
}
