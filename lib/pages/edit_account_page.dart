import 'dart:io';

import 'package:chat_app/model/account.dart';
import 'package:chat_app/utils/authentication.dart';
import 'package:chat_app/utils/function_utils.dart';
import 'package:chat_app/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({super.key});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  Account myAccount = Authentication.myAccount!;
  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController selfIntroductionController = TextEditingController();
  File? image;

  ImageProvider getImage() {
    if (image == null) {
      return NetworkImage(myAccount.imagePath);
    } else {
      return FileImage(image!);
    }
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: myAccount.name);
    userIdController = TextEditingController(text: myAccount.userId);
    selfIntroductionController =
        TextEditingController(text: myAccount.selfIntroduction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.createAppBar("Edit"),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            GestureDetector(
              onTap: () async {
                var result = await FunctionUtils.getImageFromGallery();
                if (result != null) {
                  setState(() {
                    image = File(result.path);
                  });
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
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty &&
                    userIdController.text.isNotEmpty &&
                    selfIntroductionController.text.isNotEmpty &&
                    image != null) {}
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
