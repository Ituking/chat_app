import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/setting_profile_page.dart';
import 'package:chat_app/pages/time_line_page.dart';
import 'package:chat_app/pages/top_page.dart';
import 'package:flutter/material.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({super.key});

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  int selectedIndex = 0;
  List<Widget> pageList = [
    const HomePage(),
    const TimeLinePage(),
    const TopPage(),
    const SettingProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_size_select_actual_rounded),
            label: "Media",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wechat),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting",
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.green,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
