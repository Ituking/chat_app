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
        child: Text("ImageZoomPage"),
      ),
    );
  }
}
