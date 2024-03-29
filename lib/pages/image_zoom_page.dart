import 'package:chat_app/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageZoomPage extends StatefulWidget {
  final String? imagePath;
  const ImageZoomPage({super.key, required this.imagePath});

  @override
  State<ImageZoomPage> createState() => _ImageZoomPageState();
}

class _ImageZoomPageState extends State<ImageZoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      appBar: AppBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.0),
        elevation: 0.0,
        leading: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: IconButton(
              icon: const Icon(
                CupertinoIcons.clear,
                color: CupertinoColors.black,
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Image(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.75,
                image: NetworkImage(
                  widget.imagePath!,
                ),
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    CupertinoIcons.exclamationmark_circle,
                    size: 64,
                    color: CupertinoColors.systemRed,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
