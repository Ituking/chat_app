import 'package:flutter/material.dart';

class ImageZoomPage extends StatefulWidget {
  const ImageZoomPage({super.key});

  @override
  State<ImageZoomPage> createState() => _ImageZoomPageState();
}

class _ImageZoomPageState extends State<ImageZoomPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: NetworkImage(
            "https://images.unsplash.com/photo-1472396961693-142e6e269027?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxNTgwfDB8MXxzZWFyY2h8Mjl8fE5hdHVyZXxlbnwwfHx8fDE2NzgwODY0NTY&ixlib=rb-4.0.3&q=80&w=400",
          ),
        ),
      ),
    );
  }
}
