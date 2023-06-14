import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FunctionUtils {
  static Future<dynamic> getImageFromGallery(BuildContext context) async {
    try {
      ImagePicker picker = ImagePicker();
      PermissionStatus permissionStatus = await Permission.photos.request();
      if (permissionStatus.isGranted) {
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          return File(pickedFile.path);
        } else {
          return null;
        }
      } else if (permissionStatus.isDenied ||
          permissionStatus.isPermanentlyDenied) {
        if (kDebugMode) {
          print("Access Denied.");
        }
        if (context.mounted) {
          showAlertDialog(context);
          return false;
        }
      } else {
        if (kDebugMode) {
          print("Exception occured.");
        }
        if (context.mounted) return;
        showAlertDialog(context);
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      showAlertDialog(context);
      return false;
    }
    // final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // return File(pickedFile!.path);
    // if (pickedFile != null) {
    //   setState(() {
    //     image = File(pickedFile.path);
    //   });
    // }
  }

  static void showAlertDialog(BuildContext context) async {
    await showCupertinoDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text("Permission Denied"),
        content: const Text("Allow access to gallery and photos"),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: CupertinoColors.systemRed,
              ),
            ),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => openAppSettings(),
            child: const Text(
              "Settings",
              style: TextStyle(
                color: CupertinoColors.activeBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<String> uploadImage(String uid, File image) async {
    final FirebaseStorage storageInstance = FirebaseStorage.instance;
    final Reference ref = storageInstance.ref();
    await ref.child(uid).putFile(image);
    String downloadUrl = await storageInstance.ref(uid).getDownloadURL();
    if (kDebugMode) {
      print("image_path: $downloadUrl");
    }
    return downloadUrl;
  }

  static Future saveImage(File image) async {
    try {} catch (e) {}
  }
}
