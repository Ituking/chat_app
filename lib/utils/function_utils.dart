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
          bool isOpened = await showAlertDialog(context);
          if (isOpened) {
            permissionStatus = await Permission.photos.request();
            if (permissionStatus.isGranted) {
              final pickedFile =
                  await picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                return File(pickedFile.path);
              } else {
                return null;
              }
            } else {
              return false;
            }
          } else {
            return false;
          }
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

  static Future<bool> showAlertDialog(BuildContext context) async {
    bool isOpened = false;
    await showCupertinoDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text("Allow access to Photos"),
        content: const Text(
            "This will allow you to share the contents of your camera roll and use other functions. Go to Settings and tap Photos."),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text(
              "Cancel",
            ),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              isOpened = true;
              Navigator.pop(context, true);
              openAppSettings();
            },
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
    return isOpened;
  }

  static Future<String?> uploadProfileImage(String uid, File image) async {
    final FirebaseStorage storageInstance = FirebaseStorage.instance;
    final Reference ref =
        storageInstance.ref().child('profile_image').child(uid);
    try {
      await ref.putFile(image);
      String downloadUrl = await ref.getDownloadURL();
      if (kDebugMode) {
        print(
            "Profile image uploaded successfully. Download URL: $downloadUrl");
      }
      return downloadUrl;
    } catch (e) {
      if (kDebugMode) {
        print("Failed to upload profile image: $e");
      }
      return null;
    }
  }

  static Future<String?> uploadPostImage(String uid, File image) async {
    final FirebaseStorage storageInstance = FirebaseStorage.instance;
    final Reference ref =
        storageInstance.ref().child('post_images').child(uid).child(uid);
    try {
      await ref.putFile(image);
      String downloadUrl = await ref.getDownloadURL();
      if (kDebugMode) {
        print("Post image uploaded successfully. Download URL: $downloadUrl");
      }
      return downloadUrl;
    } catch (e) {
      if (kDebugMode) {
        print("Failed to upload post image: $e");
      }
      return null;
    }
  }

  static Future saveImage(File image) async {
    try {} catch (e) {}
  }
}
