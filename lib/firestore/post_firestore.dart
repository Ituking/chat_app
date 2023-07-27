import 'package:chat_app/model/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class PostFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference posts =
      _firestoreInstance.collection('posts');

  static Future<dynamic> addPost(Post newPost) async {
    try {
      final CollectionReference userPosts = _firestoreInstance
          .collection('user')
          .doc(newPost.postAccountId)
          .collection('my_posts');
      var result = await posts.add({
        'content': newPost.postContent,
        'post_account_id': newPost.postAccountId,
        'image_path': newPost.postImagePath,
        'post_time': Timestamp.now(),
      });
      userPosts.doc(result.id).set({
        'post_id': result.id,
        'post_time': Timestamp.now(),
      });
      if (kDebugMode) {
        print("Submission Completed.");
      }
      return true;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Submission Failure. $e");
      }
      return false;
    }
  }

  static Future<List<Post>?> getPostsFromIds(List<String> ids) async {
    List<Post> postList = [];
    try {
      await Future.forEach(ids, (String elements) async {
        var doc = await posts.doc(elements).get();
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Post post = Post(
          id: doc.id,
          postImagePath: data['image_path'],
          postContent: data['content'],
          postAccountId: data['post_account_id'],
          postAccount: data[''],
          postTime: data['post_time'],
        );
        postList.add(post);
      });
      if (kDebugMode) {
        print("Success in retrieving my post.");
        print("postList => $postList");
      }
      return postList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failure to retrieve my post. $e");
      }
      return null;
    }
  }

  static Future<dynamic> deletePosts(String accountId) async {
    final CollectionReference userPosts = _firestoreInstance
        .collection('user')
        .doc(accountId)
        .collection('my_posts');
    var snapshot = await userPosts.get();
    for (var doc in snapshot.docs) {
      await posts.doc(doc.id).delete();
      userPosts.doc(doc.id).delete();
    }
  }
}
