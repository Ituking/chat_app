import 'dart:io';

import 'package:chat_app/firestore/account_firestore.dart';
import 'package:chat_app/model/account.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/utils/authentication.dart';
import 'package:chat_app/utils/function_utils.dart';
import 'package:chat_app/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
      return NetworkImage(myAccount.profileImagePath);
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
                foregroundImage: getImage(),
                backgroundColor: CupertinoColors.activeGreen,
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
                          color: CupertinoColors.black,
                          width: 2,
                        ),
                      ),
                      errorStyle: TextStyle(
                        color: CupertinoColors.systemRed,
                      ),
                    ),
                    cursorColor: CupertinoColors.black,
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
                        color: CupertinoColors.black,
                        width: 2,
                      ),
                    ),
                    errorStyle: TextStyle(
                      color: CupertinoColors.systemRed,
                    ),
                  ),
                  cursorColor: CupertinoColors.black,
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
                      color: CupertinoColors.black,
                      width: 2,
                    ),
                  ),
                  errorStyle: TextStyle(
                    color: CupertinoColors.systemRed,
                  ),
                ),
                cursorColor: CupertinoColors.black,
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
                    selfIntroductionController.text.isNotEmpty) {
                  String profileImagePath = myAccount.profileImagePath;
                  if (image != null) {
                    var result = await FunctionUtils.uploadProfileImage(
                        myAccount.id, image!);
                    if (result != null) {
                      profileImagePath = result;
                    } else {
                      if (kDebugMode) {
                        print("Failed to upload profile image.");
                      }
                      return;
                    }
                  }
                  // if (image == null) {
                  //   profileImagePath = myAccount.profileImagePath;
                  // } else {
                  //   var result = await FunctionUtils.uploadProfileImage(
                  //       myAccount.id, image!);
                  //   profileImagePath = result!;
                  // }
                  Account updateAccount = Account(
                    id: myAccount.id,
                    name: nameController.text,
                    profileImagePath: profileImagePath,
                    selfIntroduction: selfIntroductionController.text,
                    userId: userIdController.text,
                  );
                  // Authentication.myAccount = updateAccount;
                  var result = await AccountFirestore.updateUser(updateAccount);
                  if (result == true) {
                    if (!mounted) return;
                    setState(() {
                      myAccount = updateAccount;
                    });
                    Navigator.pop(context, true);
                  } else {
                    if (kDebugMode) {
                      print("Failed to update account.");
                    }
                  }
                }
              },
              child: const Text("Update"),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Authentication.signOut();
                while (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: const Text("Logout"),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CupertinoColors.systemRed,
              ),
              onPressed: () {
                AccountFirestore.deleteUser(myAccount.id);
                Authentication.deleteAuth();
                Authentication.signOut();
                while (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: const Text(
                "Delete Account",
                style: TextStyle(
                  color: CupertinoColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
