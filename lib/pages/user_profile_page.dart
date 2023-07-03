import 'package:chat_app/firestore/user_firestore.dart';
import 'package:chat_app/model/account.dart';
import 'package:chat_app/model/post.dart';
import 'package:chat_app/model/user.dart';
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
  Account? userAccount;
  List<Post> postList = [
    Post(
      id: "0001",
      postAccountId: "0001",
      postTime: Timestamp.now(),
      imagePath:
          "https://images.unsplash.com/photo-1471922694854-ff1b63b20054?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1472&q=80",
      content: 'On a sunny day, you can still go to the beach 🌊.',
    ),
    Post(
      id: "0002",
      postAccountId: "0002",
      postTime: Timestamp.now(),
      imagePath:
          "https://images.unsplash.com/photo-1542233637-20456b09d882?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
      content: 'A day healed by nature 🌳.',
    ),
    Post(
      id: "0003",
      postAccountId: "0003",
      postTime: Timestamp.now(),
      imagePath:
          "https://images.unsplash.com/photo-1542233637-20456b09d882?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
      content: 'A day healed by nature 🌳.',
    ),
    Post(
      id: "0004",
      postAccountId: "0004",
      postTime: Timestamp.now(),
      imagePath:
          "https://images.unsplash.com/photo-1542233637-20456b09d882?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
      content: 'A day healed by nature 🌳.',
    ),
    Post(
      id: "0005",
      postAccountId: "0005",
      postTime: Timestamp.now(),
      imagePath:
          "https://images.unsplash.com/photo-1542233637-20456b09d882?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
      content: 'A day healed by nature 🌳.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  Future<void> getUserProfile() async {
    User? userProfile = await UserFirestore.fetchProfile(widget.userId);
    if (userProfile != null) {
      setState(() {
        userAccount = Account(
          id: widget.userId,
          name: userProfile.name,
          imagePath: userProfile.imagePath!,
          selfIntroduction: "",
          userId: "",
        );
      });
    } else {
      if (kDebugMode) {
        print("userProfile is null.");
      }
    }
  }

  Account getUserAccountFromFirestore() {
    return Account(
      id: widget.userId,
      name: userAccount?.name ?? "",
      imagePath: userAccount?.imagePath ?? "",
      selfIntroduction: userAccount?.selfIntroduction ?? "",
      userId: userAccount?.userId ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: CupertinoColors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: userAccount != null ? buildUserProfile() : buildLoading(),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 4.0,
        valueColor: AlwaysStoppedAnimation(
          CupertinoColors.activeGreen,
        ),
      ),
    );
  }

  Widget buildUserProfile() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Stack(
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
                            child: const CircleAvatar(
                              radius: 48.0,
                              backgroundImage: NetworkImage(
                                "https://cdn.pixabay.com/photo/2023/06/13/15/05/astronaut-8061095_1280.png",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Emma",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      "Emma@1234",
                      style: TextStyle(
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
                    const Text(
                      "Hello. Everyone.",
                      maxLines: 5,
                      style: TextStyle(
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
          padding: EdgeInsets.zero,
          sliver: SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              Post post = postList[index];
              return Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(post.imagePath!),
                    fit: BoxFit.cover,
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
