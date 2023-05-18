import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});
  @override
  SigninState createState() => SigninState();
}

class SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Login'),
        ),
      ),
    );
  }
}
