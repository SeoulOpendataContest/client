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
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        //#FFC842
        primarySwatch: const MaterialColor(500, {
          300: Color(0xFFFDF8EA),
          500: Color(0xFFFFC842),
        }),
        fontFamily: 'NanumSquare',
      ),
      home: istoken ? const MainApp() : const Signin(),
    );
  }
}
