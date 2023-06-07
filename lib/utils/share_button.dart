import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  final String content;
  const ShareButton({super.key, required this.content});

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
