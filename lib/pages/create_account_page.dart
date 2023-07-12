import 'dart:io';

import 'package:chat_app/firestore/account_firestore.dart';
import 'package:chat_app/model/account.dart';
import 'package:chat_app/screens/bottom_tab_bar.dart';
import 'package:chat_app/utils/authentication.dart';
import 'package:chat_app/utils/function_utils.dart';
import 'package:chat_app/utils/widget_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  File? image;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.createAppBar("Sign Up"),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            GestureDetector(
              onTap: () async {
                var result = await FunctionUtils.getImageFromGallery(context);
                if (result != null) {
                  setState(
                    () {
                      image = File(result.path);
                    },
                  );
                }
              },
              child: CircleAvatar(
                foregroundImage: image == null ? null : FileImage(image!),
                backgroundColor: Colors.teal,
                radius: 50,
                child: const Icon(Icons.add),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: "Username",
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username is required.";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "ID is required.";
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Self Introduction is required.";
                    }
                    return null;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Form(
                  child: TextFormField(
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
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Form(
                child: TextFormField(
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
                  if (result is UserCredential) {
                    String imagePath = await FunctionUtils.uploadImage(
                        result.user!.uid, image!);
                    Account newAccount = Account(
                      id: result.user!.uid,
                      name: nameController.text,
                      imagePath: imagePath,
                      selfIntroduction: selfIntroductionController.text,
                      userId: userIdController.text,
                    );
                    var result0 = await AccountFirestore.setUser(newAccount);
                    if (result0 == true) {
                      if (!mounted) return;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomTabBar(),
                        ),
                      );
                    }
                  }
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
