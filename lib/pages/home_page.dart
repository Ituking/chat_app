import 'package:chat_app/firestore/account_firestore.dart';
import 'package:chat_app/firestore/post_firestore.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/model/account.dart';
import 'package:chat_app/model/post.dart';
import 'package:chat_app/pages/image_zoom_page.dart';
import 'package:chat_app/pages/post_comment_page.dart';
import 'package:chat_app/pages/post_page.dart';
import 'package:chat_app/utils/like_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double padValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: PostFirestore.posts.snapshots(),
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
                            imagePath: data['image_path'],
                            content: data['content'],
                            postAccountId: data['post_account_id'],
                            postTime: data['post_time'],
                          );
                          if (kDebugMode) {
                            print(post.imagePath);
                          }
                          if (kDebugMode) {
                            print(post.content);
                          }
                          if (kDebugMode) {
                            print(post.postTime);
                          }
                          Account postAccount =
                              userSnapshot.data![post.postAccountId]!;
                          return Card(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.75,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: const CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        "https://images.unsplash.com/photo-1472396961693-142e6e269027?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxNTgwfDB8MXxzZWFyY2h8Mjl8fE5hdHVyZXxlbnwwfHx8fDE2NzgwODY0NTY&ixlib=rb-4.0.3&q=80&w=400",
                                      ),
                                    ),
                                    title: Text(
                                      postAccount.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      post.postTime == null
                                          ? ""
                                          : DateFormat('yyyy-MM-dd-Hm').format(
                                              post.postTime!.toDate(),
                                            ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: post.imagePath != null
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ImageZoomPage(),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      post.imagePath!),
                                                  fit: BoxFit.cover,
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
                                              color: Colors.grey,
                                            ),
                                            child: const Icon(
                                              Icons.image,
                                              color: Colors.white,
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
                                        post.content,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 14.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: const [
                                          LikeButton(),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(
                                            "Like",
                                            style: TextStyle(
                                              color: Colors.grey,
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
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.comment,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            Text(
                                              "Comments",
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.share,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(
                                            "Share",
                                            style: TextStyle(
                                              color: Colors.grey,
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
        backgroundColor: materialWhite,
        foregroundColor: Colors.black,
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
