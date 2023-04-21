import 'dart:io';

import 'package:chat_app/firestore/post_firestore.dart';
import 'package:chat_app/model/post.dart';
import 'package:chat_app/utils/authentication.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController contentController = TextEditingController();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        centerTitle: false,
        title: const Text(
          "Create post",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (contentController.text.isNotEmpty) {
                Post newPost = Post(
                  content: contentController.text,
                  postAccountId: Authentication.myAccount!.id,
                  id: '',
                  imagePath: '',
                  postTime: null,
                );
                var result = await PostFirestore.addPost(newPost);
                if (result == true) {
                  if (!mounted) return;
                  Navigator.pop(context);
                }
              }
            },
            child: const Text(
              "Post",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: contentController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "What's on your mind?",
                  border: InputBorder.none,
                ),
                cursorColor: Colors.black,
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Add a photo"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
