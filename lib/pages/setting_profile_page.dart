import 'package:flutter/material.dart';

class SettingProfilePage extends StatefulWidget {
  const SettingProfilePage({super.key});

  @override
  State<SettingProfilePage> createState() => _SettingProfilePageState();
}

class _SettingProfilePageState extends State<SettingProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: Column(
        children: [
          Row(
            children: const [
              Text("Name"),
              Expanded(
                child: TextField(),
              ),
            ],
          ),
          Row(
            children: [
              const Text("Profile Image"),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Select Image"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
