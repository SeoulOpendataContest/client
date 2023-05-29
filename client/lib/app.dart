import 'package:flutter/material.dart';

import 'pages/home.dart';
import 'pages/store.dart';
import 'pages/kindstore.dart';
import 'pages/chat.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const StorePage(),
    const KindStorePage(),
    const ChatPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: SizedBox(
          height: 80,
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.where_to_vote_outlined),
                label: '가맹점',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.storefront_outlined),
                label: '선한가게',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.forum_outlined),
                label: '챗봇',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w900, color: Colors.black),
            selectedIconTheme:
                const IconThemeData(color: Colors.black, size: 30),
            selectedFontSize: 10,
            unselectedFontSize: 10,
          ),
        ));
  }
}
