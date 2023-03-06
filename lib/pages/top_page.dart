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
        imagePath: "photo-1472396961693-142e6e269027.jpeg",
        lastMessage: "Hello."),
    User(
        name: "John",
        uid: "0002",
        imagePath: "photo-1472396961693-142e6e269027.jpeg",
        lastMessage: "Thanks."),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChatApp"),
      ),
      body: const Center(
        child: Text("Main"),
      ),
    );
  }
}
