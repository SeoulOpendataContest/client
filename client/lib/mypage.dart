import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import 'package:dio/dio.dart';

import "signin.dart";

import 'api/client.dart';
import 'api/log_interceptor.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);
  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends State<MyPage> {
  bool isCard = false;
  String accessToken = '';
  List<CardContent> result = [];

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken') ?? '';
    if (accessToken != '') {
      setState(() {
        isCard = true;
      });
      try {
        final dio = Dio()..interceptors.add(CustomLogInterceptor());
        final restClient = ClientPerson(dio);
        final response =
            await restClient.getCardList(jsondata: {"email": accessToken});
        setState(() {
          result = response;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  void deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken') ?? '';
    if (accessToken != '') {
      try {
        final dio = Dio()..interceptors.add(CustomLogInterceptor());
        final restClient = ClientPerson(dio);
        await restClient.delete(jsondata: {"email": accessToken});
      } catch (e) {
        print(e);
      }
    }
  }

  void removeString() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('accessToken');
  }

  @override
  void initState() {
    super.initState();
    loadData();
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
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 200,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(children: [
                      SizedBox(width: 20),
                      Text("안녕하세요, ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))
                    ]),
                    const SizedBox(height: 10),
                    Row(children: [
                      const SizedBox(width: 20),
                      const Text("어깨동무 님",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      const SizedBox(width: 10),
                      // edit icon

                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            overlayColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 246, 246, 246)),
                            elevation: MaterialStateProperty.all(0.0),
                          ),
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.grey,
                                size: 15,
                              ),
                              SizedBox(width: 5),
                              Text('닉네임 수정하기',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10)),
                            ],
                          ))
                    ])
                  ]),
            ),
            Container(height: 8, color: const Color(0xFFE9E9E9)),
            // log out button
            ElevatedButton(
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
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
              child: const Row(children: [
                SizedBox(width: 10),
                Text('로그아웃', style: TextStyle(fontWeight: FontWeight.bold))
              ]),
            ),
            Container(height: 8, color: const Color(0xFFE9E9E9)),
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
                deleteData();
                removeString();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Signin()),
                );
              },
              child: const Row(children: [
                SizedBox(width: 10),
                Text('탈퇴하기', style: TextStyle(fontWeight: FontWeight.bold))
              ]),
            ),
            Container(height: 8, color: const Color(0xFFE9E9E9)),
          ],
        ));
  }
}
