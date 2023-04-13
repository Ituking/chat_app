import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController selfIntroductionController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const CircleAvatar(
              backgroundColor: Colors.green,
              radius: 40,
              child: Icon(Icons.add),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Name",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
