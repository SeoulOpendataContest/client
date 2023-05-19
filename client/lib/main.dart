import 'package:flutter/material.dart';

import 'signin.dart';
import 'app.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});
  @override
  Widget build(BuildContext context) {
    bool istoken = false;
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        // fontFamily: 'NotoSansKR',
        // textTheme: const TextTheme()
      ),
      home: istoken ? const MainApp() : const Signin(),
    );
  }
}
