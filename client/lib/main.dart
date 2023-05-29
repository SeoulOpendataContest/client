import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'signin.dart';
import 'app.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const Main());
  FlutterNativeSplash.remove();
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    bool istoken = false;

    final prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      if (value.getString('accessToken') != null) {
        istoken = true;
        print(value.getString('accessToken'));
      }
    });

    return MaterialApp(
      title: '어깨동무',
      theme: ThemeData(
          canvasColor: Colors.white,
          primarySwatch: Colors.amber,
          fontFamily: 'NanumSquare'),
      home: istoken ? const MainApp() : const Signin(),
    );
  }
}
