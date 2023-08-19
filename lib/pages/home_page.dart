import 'package:chat_app/firestore/account_firestore.dart';
import 'package:chat_app/firestore/post_firestore.dart';
import 'package:chat_app/model/account.dart';
import 'package:chat_app/model/post.dart';
import 'package:chat_app/pages/image_zoom_page.dart';
import 'package:chat_app/pages/post_comment_page.dart';
import 'package:chat_app/pages/post_page.dart';
import 'package:chat_app/utils/authentication.dart';
import 'package:chat_app/utils/like_button.dart';
import 'package:chat_app/utils/share_button.dart';
import 'package:chat_app/utils/timeago.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double padValue = 0;
  Account myAccount = Authentication.myAccount!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: PostFirestore.posts
              .orderBy('post_time', descending: true)
              .snapshots(),
          builder: (context, postSnapshot) {
            if (postSnapshot.hasData) {
              List<String> postAccountIds = [];
              for (var doc in postSnapshot.data!.docs) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                if (!postAccountIds.contains(data['post_account_id'])) {
                  postAccountIds.add(data['post_account_id']);
                }
              }
              return FutureBuilder<Map<String, Account>?>(
                  future: AccountFirestore.getPostUserMap(postAccountIds),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.hasData &&
                        userSnapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount: postSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data =
                              postSnapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                          Post post = Post(
                            id: postSnapshot.data!.docs[index].id,
                            postImagePath: data['image_path'],
                            postContent: data['content'],
                            postAccountId: data['post_account_id'],
                            postAccount:
                                userSnapshot.data![data['post_account_id']],
                            postTime: data['post_time'],
                            likedCount: data['liked_count'],
                          );
                          bool isLiked =
                              post.likedUserIds.contains(myAccount.id);
                          if (kDebugMode) {
                            print(post.postImagePath);
                          }
                          if (kDebugMode) {
                            print(post.postContent);
                          }
                          if (kDebugMode) {
                            print(post.postTime);
                          }
                          if (kDebugMode) {
                            print(post.likedCount);
                          }
                          return Card(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.75,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        post.postAccount!.profileImagePath,
                                      ),
                                    ),
                                    title: Text(
                                      post.postAccount?.name ?? "Unknown",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: CupertinoColors.black,
                                      ),
                                    ),
                                    subtitle: Text(
                                      post.postTime == null
                                          ? ""
                                          : createTimeAgoString(
                                              post.postTime!.toDate(),
                                            ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: CupertinoColors.systemGrey,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: post.postImagePath != null
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (
                                                    context,
                                                    animation,
                                                    secondaryAnimation,
                                                  ) =>
                                                      ImageZoomPage(
                                                    imagePath:
                                                        post.postImagePath!,
                                                  ),
                                                  transitionsBuilder: (
                                                    context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child,
                                                  ) {
                                                    return const FadeUpwardsPageTransitionsBuilder()
                                                        .buildTransitions(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ImageZoomPage(
                                                          imagePath: post
                                                              .postImagePath!,
                                                        ),
                                                      ),
                                                      context,
                                                      animation,
                                                      secondaryAnimation,
                                                      child,
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 5.0,
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          24.0),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        post.postImagePath!),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                              color: CupertinoColors.systemGrey,
                                            ),
                                            child: const Icon(
                                              Icons.image,
                                              color: CupertinoColors.white,
                                              size: 64.0,
                                            ),
                                          ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 25.0,
                                    ),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      width: double.infinity,
                                      child: Text(
                                        post.postContent,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color: CupertinoColors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          LikeButton(
                                            post: post,
                                          ),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(
                                            "${post.likedCount}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              color: CupertinoColors.black,
                                            ),
                                          ),
                                        ],
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
                                              width: 8.0,
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
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  });
            } else {
              return Container();
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CupertinoColors.activeGreen,
        elevation: 0.0,
        foregroundColor: CupertinoColors.white,
        onPressed: () => showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: const PostPage(),
                ),
              ),
            );
          },
        ),
        child: const Icon(
          CupertinoIcons.add,
        ),
      ),
    );
  }
}
