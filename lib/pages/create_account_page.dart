import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.green,
        ),
        title: const Text(
          "Sign Up",
        ),
      ),
      body: Center(
        child: Column(
          children: const [
            CircleAvatar(
              radius: 40,
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
