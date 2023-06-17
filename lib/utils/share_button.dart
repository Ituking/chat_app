import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  final String content;
  const ShareButton({super.key, required this.content});

  Future<void> share() async {
    await Share.share(content);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        share();
      },
      icon: const Icon(
        Icons.ios_share_outlined,
        color: CupertinoColors.black,
      ),
    );
  }
}
