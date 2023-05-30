import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatefulWidget {
  const ShareButton({super.key});

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  String text = "";
  String subject = "";
  List<String> imageNames = [];
  List<XFile> imagePaths = [];

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (kDebugMode) {
          print("ShareButtonTaped.");
        }
      },
      icon: const Icon(
        Icons.ios_share_outlined,
        color: Colors.grey,
      ),
    );
  }

  void shareText(String text, String subject) async {
    await Share.share(text, subject: subject);
  }
}
