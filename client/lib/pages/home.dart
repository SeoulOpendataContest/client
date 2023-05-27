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
    return isCard
        ? Scaffold(
            body: Container(
              child: Center(
                child: Text('card'),
              ),
            ),
          )
        : Scaffold(
            body: Container(
              // add card button
              child: Center(
                child: Text('no card'),
              ),
            ),
          );
  }
}
