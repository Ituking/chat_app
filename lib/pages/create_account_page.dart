import 'dart:io';

import 'package:chat_app/screens/bottom_tab_bar.dart';
import 'package:chat_app/utils/authentication.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  File? image;
  ImagePicker picker = ImagePicker();

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            GestureDetector(
              onTap: () {
                getImageFromGallery();
              },
              child: CircleAvatar(
                foregroundImage: image == null ? null : FileImage(image!),
                backgroundColor: Colors.green,
                radius: 50,
                child: const Icon(Icons.add),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: "Name",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      errorStyle: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    cursorColor: Colors.black,
                    cursorWidth: 2.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: userIdController,
                  decoration: const InputDecoration(
                    hintText: "ID",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  cursorColor: Colors.black,
                  cursorWidth: 2.0,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                controller: selfIntroductionController,
                decoration: const InputDecoration(
                  hintText: "Self Introduction",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  errorStyle: TextStyle(
                    color: Colors.red,
                  ),
                ),
                cursorColor: Colors.black,
                cursorWidth: 2.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "Email Address",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  cursorColor: Colors.black,
                  cursorWidth: 2.0,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: "Password",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  errorStyle: TextStyle(
                    color: Colors.red,
                  ),
                ),
                cursorColor: Colors.black,
                cursorWidth: 2.0,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty &&
                    userIdController.text.isNotEmpty &&
                    selfIntroductionController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty &&
                    image != null) {
                  var result = await Authentication.signUp(
                      emailController.text, passwordController.text);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomTabBar(),
                    ),
                  );
                }
              },
              child: const Text("Create an account"),
            ),
          ],
        ),
      ),
    );
  }
}
