import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class FunctionUtils {
  static Future<dynamic> getImageFromGallery(BuildContext context) async {
    try {} catch (e) {}
    // ImagePicker picker = ImagePicker();
    // final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // return File(pickedFile!.path);
    // if (pickedFile != null) {
    //   setState(() {
    //     image = File(pickedFile.path);
    //   });
    // }
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
}
