import 'package:flutter/material.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sample App'),
        ),
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
            //selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            //text size
            selectedFontSize: 10,
            unselectedFontSize: 10,
            //hieght
          ),
        ));
  }
}
