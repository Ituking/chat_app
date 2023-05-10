import 'package:chat_app/firestore/comment_firestore.dart';
import 'package:chat_app/model/account.dart';
import 'package:chat_app/model/comment.dart';
import 'package:chat_app/utils/authentication.dart';
import 'package:chat_app/utils/widget_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostCommentPage extends StatefulWidget {
  const PostCommentPage({super.key});

  @override
  State<PostCommentPage> createState() => _PostCommentPageState();
}

class _PostCommentPageState extends State<PostCommentPage> {
  Account commentAccount = Account(
    id: "1",
    name: "Emma",
    imagePath:
        "https://images.unsplash.com/photo-1472396961693-142e6e269027?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxNTgwfDB8MXxzZWFyY2h8Mjl8fE5hdHVyZXxlbnwwfHx8fDE2NzgwODY0NTY&ixlib=rb-4.0.3&q=80&w=400",
    selfIntroduction:
        "Hi everyone! I'm Emma. I'm passionate about Programming, and love sharing my experiences and thoughts with others.",
    userId: "0001",
  );

  List<Comment> commentList = [
    Comment(
      id: "1",
      content: "Beautiful photo! You're such a talented photographer.",
      commentAccountId: "1",
      commentTime: Timestamp.now(),
    ),
    Comment(
      id: "2",
      content: "This place looks amazing! I need to add it to my travel list.",
      commentAccountId: "2",
      commentTime: Timestamp.now(),
    ),
  ];

  TextEditingController contentController = TextEditingController();

  late final bottomSpace = MediaQuery.of(context).viewInsets.bottom;
  double getScreenHeight() => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: WidgetUtils.createAppBar("Comment"),
      body: SingleChildScrollView(
        reverse: true,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              child: ListView.builder(
                itemCount: commentList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CircleAvatar(
                            radius: 20,
                            foregroundImage:
                                NetworkImage(commentAccount.imagePath),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        commentAccount.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '@${commentAccount.userId}',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    DateFormat('yyyy-MM-dd-Hm').format(
                                      commentList[index].commentTime!.toDate(),
                                    ),
                                  ),
                                ],
                              ),
                              Text(commentList[index].content),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: getScreenHeight() * 0.4,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: contentController,
                        autofocus: true,
                        cursorColor: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () async {
                          if (contentController.text.isNotEmpty) {
                            Comment newComment = Comment(
                              content: contentController.text,
                              commentAccountId: Authentication.myAccount!.id,
                              id: '',
                              commentTime: null,
                            );
                            var result =
                                await CommentFirestore.addComment(newComment);
                            if (result == true) {
                              if (!mounted) return;
                              Navigator.pop(context);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
