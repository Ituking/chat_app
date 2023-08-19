import 'package:chat_app/model/account.dart';
import 'package:chat_app/model/post.dart';
import 'package:chat_app/pages/image_zoom_page.dart';
import 'package:chat_app/pages/post_comment_page.dart';
import 'package:chat_app/utils/authentication.dart';
import 'package:chat_app/utils/like_button.dart';
import 'package:chat_app/utils/share_button.dart';
import 'package:chat_app/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;
  final Account account;
  const PostDetailPage({super.key, required this.post, required this.account});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  Account myAccount = Authentication.myAccount!;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    String formattedTime =
        DateFormat.yMMMd().format(widget.post.postTime!.toDate());
    return Scaffold(
      appBar: WidgetUtils.createAppBar("Post"),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.account.profileImagePath,
                ),
              ),
              title: Text(
                widget.account.name!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.black,
                ),
              ),
              subtitle: Text(
                formattedTime,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageZoomPage(
                      imagePath: widget.post.postImagePath,
                    ),
                  ),
                );
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  child: Hero(
                    tag: "post_${widget.post.id}",
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        image: DecorationImage(
                          image: NetworkImage(widget.post.postImagePath!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 10.0,
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: Text(
                  widget.post.postContent,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: CupertinoColors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 14.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    LikeButton(
                      post: widget.post,
                      isLiked:
                          widget.post.likedUserIds.contains(widget.account.id),
                      onPressed: () {},
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "${widget.post.likedCount}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: CupertinoColors.black,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PostCommentPage(),
                      ),
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.mode_comment_outlined,
                        color: CupertinoColors.black,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "Comments",
                        style: TextStyle(
                          color: CupertinoColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    ShareButton(
                      content: widget.post.postContent,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    const Text(
                      "Share",
                      style: TextStyle(
                        color: CupertinoColors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(
              height: 1.0,
              thickness: 0.5,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
