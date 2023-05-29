import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

import "signin.dart";

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);
  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends State<MyPage> {
  bool isCard = false;

  void removeString() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('accessToken');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: const Border(bottom: BorderSide(color: Color(0xFFABABAB))),
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            '회원 정보',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 100,
              child: Column(children: [Text("안녕하세요"), Text("서울시 님")]),
            ),
            Container(height: 5, color: const Color(0xFFE9E9E9)),
            // log out button
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width, 50),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                overlayColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 246, 246, 246)),
                elevation: MaterialStateProperty.all(0.0),
              ),
              onPressed: () async {
                removeString();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Signin()),
                );
              },
              child: const Text('로그아웃'),
            ),
            Container(height: 5, color: const Color(0xFFE9E9E9)),
          ],
        ));
  }
}
