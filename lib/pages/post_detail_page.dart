import 'package:chat_app/firestore/post_firestore.dart';
import 'package:chat_app/model/account.dart';
import 'package:chat_app/model/post.dart';
import 'package:chat_app/pages/image_zoom_page.dart';
import 'package:chat_app/pages/post_comment_page.dart';
import 'package:chat_app/utils/authentication.dart';
import 'package:chat_app/utils/like_button.dart';
import 'package:chat_app/utils/share_button.dart';
import 'package:chat_app/utils/widget_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;
  final Account account;
  const PostDetailPage({super.key, required this.post, required this.account});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  Account myAccount = Authentication.myAccount!;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.post.likedUserIds.contains(myAccount.id);
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime =
        DateFormat.yMMMd().format(widget.post.postTime!.toDate());
    return Scaffold(
      appBar: WidgetUtils.createAppBar("Post"),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: PostFirestore.posts.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CupertinoActivityIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (snapshot.hasData) {
                return FutureBuilder<Map<String, dynamic>?>(
                    future: PostFirestore.fetchPostData(widget.post),
                    builder: (context, postSnapshot) {
                      if (postSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CupertinoActivityIndicator();
                      } else if (postSnapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (postSnapshot.hasData &&
                          postSnapshot.connectionState ==
                              ConnectionState.done) {
                        Map<String, dynamic> data = postSnapshot.data!;
                        Post post = Post(
                          id: widget.post.id,
                          postImagePath: data['image_path'],
                          postContent: data['content'],
                          postAccountId: data['post_account_id'],
                          postAccount: data['post_account'],
                          postTime: data['post_time'],
                          likedUserIds: List<String>.from(
                            data['liked_user_ids'] ?? [],
                          ),
                        );
                        bool isLiked = post.likedUserIds.contains(myAccount.id);
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  widget.account.profileImagePath,
                                ),
                              ),
                              title: Text(
                                widget.account.name!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CupertinoColors.black,
                                ),
                              ),
                              subtitle: Text(
                                formattedTime,
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 10.0,
                              ),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ImageZoomPage(
                                          imagePath: data['image_path'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: "post_${widget.post.id}",
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            data['image_path'],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 23.0,
                                vertical: 10.0,
                              ),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: double.infinity,
                                child: Text(
                                  data['content'],
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: CupertinoColors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                LikeButton(
                                  post: post,
                                  isLiked: isLiked,
                                  onPressed: () async {
                                    try {
                                      if (kDebugMode) {
                                        print(
                                            "onPressed time isLiked => $isLiked");
                                      }
                                      await FirebaseFirestore.instance
                                          .collection('posts')
                                          .doc(widget.post.id)
                                          .update({
                                        'liked_count': FieldValue.increment(
                                            isLiked ? -1 : 1),
                                        'liked_user_ids': isLiked
                                            ? FieldValue.arrayRemove(
                                                [myAccount.id])
                                            : FieldValue.arrayUnion(
                                                [myAccount.id]),
                                      });
                                      if (kDebugMode) {
                                        print(
                                            "Firestore data updated successfully.");
                                      }
                                    } on FirebaseException catch (e) {
                                      if (kDebugMode) {
                                        print("Firestore update error: $e");
                                      }
                                    }
                                  },
                                ),
                                Text(
                                  data['liked_count'].toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: CupertinoColors.black,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PostCommentPage(),
                                      ),
                                    );
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.mode_comment_outlined,
                                        color: CupertinoColors.black,
                                      ),
                                      SizedBox(
                                        width: 13.0,
                                      ),
                                      Text(
                                        "Comments",
                                        style: TextStyle(
                                          color: CupertinoColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    ShareButton(
                                      content: post.postContent,
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    const Text(
                                      "Share",
                                      style: TextStyle(
                                        color: CupertinoColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      return const Text("No Data");
                    });
              }
              return const Text("No Data");
            }),
      ),
    );
  }
}
