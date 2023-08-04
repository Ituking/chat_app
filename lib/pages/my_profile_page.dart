import 'dart:io';

import 'package:chat_app/firestore/post_firestore.dart';
import 'package:chat_app/firestore/user_firestore.dart';
import 'package:chat_app/model/account.dart';
import 'package:chat_app/model/post.dart';
import 'package:chat_app/pages/edit_account_page.dart';
import 'package:chat_app/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  Account myAccount = Authentication.myAccount!;
  File? image;
  String imagePath = '';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            color: CupertinoColors.systemGrey,
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: 200.0,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
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
                          backgroundImage:
                              NetworkImage(myAccount.profileImagePath),
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
                              backgroundImage:
                                  NetworkImage(myAccount.profileImagePath),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 80.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditAccountPage(),
                                ),
                              );
                              if (result == true) {
                                setState(
                                  () {
                                    myAccount = Authentication.myAccount!;
                                  },
                                );
                              }
                            },
                            child: const Text(
                              "Edit",
                              style: TextStyle(
                                color: CupertinoColors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      myAccount.name!,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      myAccount.userId!,
                      style: const TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'About',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      myAccount.selfIntroduction!,
                      maxLines: 5,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: UserFirestore.fetchUserPostsStream(myAccount.id),
                      builder: (context, snapshot) {
                        if (kDebugMode) {
                          print("StreamBuilder snapshot: $snapshot");
                        }
                        if (snapshot.hasData) {
                          List<String> myPostIds = List.generate(
                              snapshot.data!.docs.length, (index) {
                            return snapshot.data!.docs[index].id;
                          });
                          if (kDebugMode) {
                            print("snapshot: $snapshot");
                          }
                          if (kDebugMode) {
                            print("myPostIds: $myPostIds");
                          }
                          return FutureBuilder<List<Post>?>(
                            future: PostFirestore.getPostsFromIds(myPostIds),
                            builder: (context, futureSnapshot) {
                              if (futureSnapshot.connectionState ==
                                  ConnectionState.done) {
                                if (kDebugMode) {
                                  print("futureSnapshot: $futureSnapshot");
                                }
                                if (futureSnapshot.hasData &&
                                    futureSnapshot.data!.isNotEmpty) {
                                  return GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3),
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: futureSnapshot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Post post = futureSnapshot.data![index];
                                      return Container(
                                        margin: const EdgeInsets.all(2.0),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              post.postImagePath!,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      );
                                    },
                                  );
                                } else if (futureSnapshot.hasError) {
                                  return Center(
                                    child:
                                        Text('Error: ${futureSnapshot.error}'),
                                  );
                                } else {
                                  return const Center(
                                    child: Text('No Posts'),
                                  );
                                }
                              } else {
                                return const Center(
                                  child: CupertinoActivityIndicator(),
                                );
                              }
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
