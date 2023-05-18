import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  Main({super.key});
  bool isToken = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        // fontFamily: 'NotoSansKR',
        // textTheme: const TextTheme(

        // )
      ),
      home: const MainApp(),
    );
  }
}
