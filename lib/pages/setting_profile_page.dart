import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class SettingProfilePage extends StatefulWidget {
  const SettingProfilePage({super.key});

  @override
  State<SettingProfilePage> createState() => _SettingProfilePageState();
}

class _SettingProfilePageState extends State<SettingProfilePage> {
  File? image;
  String imagePath = '';
  final ImagePicker _picker = ImagePicker();

  Future<void> selectImage() async {
    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      final File imageFile = File(pickedImage.path);
      final Uint8List imageBytes = await imageFile.readAsBytes();
      if (imageBytes.isNotEmpty) {
        setState(() {
          image = imageFile;
        });
      } else {
        throw PlatformException(
            code: 'invalid_image',
            message: 'Cannot load representation of selected image',
            details: null);
      }
    } on PlatformException catch (e) {
      debugPrint('Image picker error: $e');
    }
  }

  Future<void> uploadImage() async {
    final ref = FirebaseStorage.instance.ref('test.png');
    final storedImage = await ref.putFile(image!);
    imagePath = await storedImage.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: const [
                SizedBox(width: 150, child: Text("Name")),
                Expanded(
                  child: TextField(),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                const SizedBox(width: 150, child: Text("Profile Image")),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        selectImage();
                      },
                      child: const Text("Select Image"),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            image == null
                ? const SizedBox()
                : SizedBox(
                    width: 350,
                    height: 200,
                    child: Image.file(
                      image!,
                      fit: BoxFit.cover,
                    )),
            const SizedBox(
              height: 150,
            ),
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Edit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
