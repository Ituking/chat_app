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
              child: StreamBuilder<QuerySnapshot>(
                  stream: CommentFirestore.comments.snapshots(),
                  builder: (context, commentSnapshot) {
                    if (commentSnapshot.hasData) {
                      List<String> commentAccountIds = [];
                      for (var doc in commentSnapshot.data!.docs) {
                        Map<String, dynamic> data =
                            doc.data() as Map<String, dynamic>;
                        if (!commentAccountIds
                            .contains(data['comment_account_id'])) {
                          commentAccountIds.add(data['comment_account_id']);
                        }
                      }
                      return FutureBuilder<Map<String, Account>?>(
                          future: CommentFirestore.getCommentUserMap(
                              commentAccountIds),
                          builder: (context, userSnapshot) {
                            if (userSnapshot.hasData &&
                                userSnapshot.connectionState ==
                                    ConnectionState.done) {
                              return ListView.builder(
                                itemCount: commentSnapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> data =
                                      commentSnapshot.data!.docs[index].data()
                                          as Map<String, dynamic>;
                                  Comment comment = Comment(
                                    id: commentSnapshot.data!.docs[index].id,
                                    content: data['content'],
                                    commentAccountId:
                                        data['comment_account_id'],
                                    commentTime: data['comment_time'],
                                  );
                                  Account commentAccount = userSnapshot
                                      .data![comment.commentAccountId]!;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: CircleAvatar(
                                            radius: 20,
                                            foregroundImage: NetworkImage(
                                                commentAccount.imagePath),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        commentAccount.name,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                    DateFormat('yyyy-MM-dd-Hm')
                                                        .format(
                                                      comment.commentTime!
                                                          .toDate(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(comment.content),
                                            ],
                                          ),
                                        ),
                                      ],
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
