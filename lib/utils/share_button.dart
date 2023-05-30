import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ShareButton extends StatefulWidget {
  const ShareButton({super.key});

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  String text = "";
  String subject = "";

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
}
