import 'package:chat_app/model/post.dart';
import 'package:chat_app/pages/image_zoom_page.dart';
import 'package:chat_app/pages/user_profile_page.dart';
import 'package:chat_app/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;
  const PostDetailPage({super.key, required this.post});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.createAppBar("Post"),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfilePage(
                      userId: widget.post.postAccountId,
                    ),
                  ),
                );
              },
              child: ListTile(
                leading: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfilePage(
                          userId: widget.post.postAccountId,
                        ),
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://cdn.pixabay.com/photo/2023/06/13/15/05/astronaut-8061095_1280.png",
                    ),
                  ),
                ),
                title: const Text(
                  "Emma",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.black,
                  ),
                ),
                subtitle: const Text(
                  "3 days ago",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageZoomPage(
                      imagePath: widget.post.imagePath,
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
                          image: NetworkImage(widget.post.imagePath!),
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
                vertical: 25.0,
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: Text(
                  widget.post.content,
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
          ],
        ),
      ),
    );
  }
}
