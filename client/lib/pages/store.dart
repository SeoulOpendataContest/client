import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePage createState() => _StorePage();
}

class _StorePage extends State<StorePage> {
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
