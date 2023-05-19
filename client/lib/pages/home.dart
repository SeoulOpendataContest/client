import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isCard = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Home'),
      ),
    );
  }
}
