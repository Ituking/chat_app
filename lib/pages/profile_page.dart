import 'package:chat_app/model/account.dart';
import 'package:chat_app/model/post.dart';
import 'package:chat_app/pages/edit_account_page.dart';
import 'package:chat_app/utils/authentication.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Account myAccount = Authentication.myAccount!;
  List<Post> postList = [
    Post(
      id: "0001",
      postAccountId: "0001",
      postTime: DateTime.now(),
      imagePath:
          "https://images.unsplash.com/photo-1471922694854-ff1b63b20054?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1472&q=80",
    ),
    Post(
      id: "0002",
      postAccountId: "0002",
      postTime: DateTime.now(),
      imagePath:
          "https://images.unsplash.com/photo-1542233637-20456b09d882?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            color: Colors.grey,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
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
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(myAccount.imagePath),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 48.0,
                            backgroundImage: NetworkImage(myAccount.imagePath),
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
                          },
                          child: const Text(
                            "Edit",
                            style: TextStyle(
                              color: Colors.black,
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
                    myAccount.name,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    myAccount.userId,
                    style: const TextStyle(
                      color: Colors.grey,
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
                    myAccount.selfIntroduction,
                    maxLines: 5,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: postList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(postList[index].imagePath!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
