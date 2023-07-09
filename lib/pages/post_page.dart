import 'dart:io';

import 'package:chat_app/firestore/post_firestore.dart';
import 'package:chat_app/model/post.dart';
import 'package:chat_app/utils/authentication.dart';
import 'package:chat_app/utils/function_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController contentController = TextEditingController();
  File? image;
  String uid = Authentication.myAccount!.id;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: CupertinoColors.black,
        ),
        centerTitle: false,
        title: const Text(
          "Create post",
          style: TextStyle(
            color: CupertinoColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () async {
              if (contentController.text.isNotEmpty && image != null) {
                final downloadUrl =
                    await FunctionUtils.uploadImage(uid, image!);
                Post newPost = Post(
                  content: contentController.text,
                  postAccountId: Authentication.myAccount!.id,
                  id: '',
                  imagePath: downloadUrl,
                  postTime: Timestamp.now(),
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
                color: CupertinoColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: contentController,
                maxLines: null,
                focusNode: focusNode,
                decoration: const InputDecoration(
                  hintText: "What's on your mind?",
                  border: InputBorder.none,
                ),
                cursorColor: CupertinoColors.black,
              ),
              const SizedBox(
                height: 30,
              ),
              image == null
                  ? const SizedBox()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(24.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Image.file(
                          image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(CupertinoIcons.photo_fill),
                title: const Text("Add a photo"),
                onTap: () async {
                  var result = await FunctionUtils.getImageFromGallery(context);
                  if (result != null && result is File) {
                    setState(
                      () {
                        image = result;
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
