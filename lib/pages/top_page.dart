import 'package:chat_app/model/user.dart';
import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<User> userList = [
    User(
      name: "Emma",
      uid: "0001",
      imagePath:
          "https://images.unsplash.com/photo-1472396961693-142e6e269027?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxNTgwfDB8MXxzZWFyY2h8Mjl8fE5hdHVyZXxlbnwwfHx8fDE2NzgwODY0NTY&ixlib=rb-4.0.3&q=80&w=400",
      lastMessage: "Hello.",
    ),
    User(
      name: "John",
      uid: "0002",
      imagePath:
          "https://images.unsplash.com/photo-1472396961693-142e6e269027?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxNTgwfDB8MXxzZWFyY2h8Mjl8fE5hdHVyZXxlbnwwfHx8fDE2NzgwODY0NTY&ixlib=rb-4.0.3&q=80&w=400",
      lastMessage: "Thanks.",
    ),
    User(
      name: "Michael",
      uid: "0003",
      imagePath:
          "https://images.unsplash.com/photo-1472396961693-142e6e269027?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxNTgwfDB8MXxzZWFyY2h8Mjl8fE5hdHVyZXxlbnwwfHx8fDE2NzgwODY0NTY&ixlib=rb-4.0.3&q=80&w=400",
      lastMessage: "Welcome.",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChatApp"),
      ),
      body: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 70,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: userList[0].imagePath == null
                          ? null
                          : NetworkImage(userList[0].imagePath!),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Emma",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Hello.",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
