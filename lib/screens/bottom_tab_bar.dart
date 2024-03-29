import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/my_profile_page.dart';
import 'package:chat_app/pages/time_line_page.dart';
import 'package:chat_app/pages/top_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({super.key});

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  int selectedIndex = 0;
  List<Widget> pageList = [
    HomePage(),
    const TimeLinePage(),
    const TopPage(),
    const MyProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_size_select_actual_outlined),
            label: "Media",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.messenger_outline_rounded),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: CupertinoColors.activeGreen,
        onTap: (index) {
          setState(
            () {
              selectedIndex = index;
            },
          );
        },
      ),
    );
  }
}
