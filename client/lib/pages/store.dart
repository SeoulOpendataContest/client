import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});
  @override
  StorePageState createState() => StorePageState();
}

class StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Store'),
        ),
      ),
    );
  }
}
