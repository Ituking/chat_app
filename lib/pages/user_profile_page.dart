import 'package:chat_app/firestore/account_firestore.dart';
import 'package:chat_app/model/account.dart';
import 'package:chat_app/model/post.dart';
import 'package:chat_app/pages/post_detail_page.dart';
import 'package:chat_app/utils/widget_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  final String userId;
  const UserProfilePage({super.key, required this.userId});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  static Account? userAccount;
  List<Post> postList = [
    Post(
      id: "0001",
      postAccountId: "0001",
      postTime: Timestamp.now(),
      postImagePath:
          "https://images.unsplash.com/photo-1471922694854-ff1b63b20054?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1472&q=80",
      postContent: 'On a sunny day, you can still go to the beach 🌊.',
    ),
    Post(
      id: "0002",
      postAccountId: "0002",
      postTime: Timestamp.now(),
      postImagePath:
          "https://images.unsplash.com/photo-1542233637-20456b09d882?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
      postContent: 'A day healed by nature 🌳.',
    ),
    Post(
      id: "0003",
      postAccountId: "0003",
      postTime: Timestamp.now(),
      postImagePath:
          "https://images.unsplash.com/photo-1542233637-20456b09d882?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
      postContent: 'A day healed by nature 🌳.',
    ),
    Post(
      id: "0004",
      postAccountId: "0004",
      postTime: Timestamp.now(),
      postImagePath:
          "https://images.unsplash.com/photo-1542233637-20456b09d882?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
      postContent: 'A day healed by nature 🌳.',
    ),
    Post(
      id: "0005",
      postAccountId: "0005",
      postTime: Timestamp.now(),
      postImagePath:
          "https://images.unsplash.com/photo-1542233637-20456b09d882?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
      postContent: 'A day healed by nature 🌳.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  Future<void> getUserProfile() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("account")
          .doc(widget.userId)
          .get();
      if (snapshot.exists) {
        Account? userProfile =
            await AccountFirestore.fetchProfile(widget.userId);
        if (userProfile != null) {
          setState(
            () {
              userAccount = Account(
                id: widget.userId,
                name: userProfile.name,
                profileImagePath: userProfile.profileImagePath,
                selfIntroduction: userProfile.selfIntroduction,
                userId: userProfile.userId,
              );
            },
          );
        } else {
          if (kDebugMode) {
            print("userProfile is null.");
          }
        }
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failure to retrieve information from Firebase: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.createAppBar("Profile"),
      body: userAccount != null ? buildUserProfile() : buildLoading(),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }

  Widget buildUserProfile() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Stack(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://cdn.pixabay.com/photo/2023/06/13/15/05/astronaut-8061095_1280.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 16.0,
                    right: 16.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "100Followers",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.white,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          "200Following",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 140.0, 16.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 50.0,
                          backgroundColor: CupertinoColors.white,
                          backgroundImage: const NetworkImage(
                            "https://cdn.pixabay.com/photo/2023/06/13/15/05/astronaut-8061095_1280.png",
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: CupertinoColors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: CupertinoColors.white,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 48.0,
                              backgroundImage: NetworkImage(
                                userAccount!.profileImagePath,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      userAccount!.name,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      userAccount!.userId,
                      style: const TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Text(
                      "About",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      userAccount!.selfIntroduction,
                      maxLines: 5,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(4.0),
          sliver: SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
            itemBuilder: (context, index) {
              Post post = postList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetailPage(
                        post: post,
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: "post_${post.id}",
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(post.postImagePath!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: postList.length,
          ),
        ),
      ],
    );
  }
}
