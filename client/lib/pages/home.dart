import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:dio/dio.dart';

import "addcard.dart";
import '../mypage.dart';

import '../api/client.dart';
import '../api/log_interceptor.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String accessToken = '';
  String? result;
  MyCard? mycard;
  List<CardContent>? cardcontent;

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken') ?? '';
    if (accessToken != '') {
      try {
        final dio = Dio()..interceptors.add(CustomLogInterceptor());
        final restClient = ClientPerson(dio);
        final response =
            await restClient.getCardList(jsondata: {"email": accessToken});
        setState(() {
          result = response;
          if (result != null) {
            getcard();
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }

  void loadcard() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken') ?? '';
    if (accessToken != '') {
      try {
        final dio = Dio()..interceptors.add(CustomLogInterceptor());
        final restClient = ClientPerson(dio);
        final response =
            await restClient.checkUsage(jsondata: {"email": accessToken});
        setState(() {
          cardcontent = response;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  void getcard() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken') ?? '';
    if (accessToken != '') {
      try {
        final dio = Dio()..interceptors.add(CustomLogInterceptor());
        final restClient = ClientPerson(dio);
        final response =
            await restClient.updateCard(jsondata: {"email": accessToken});
        setState(() {
          mycard = response;
          if (result != null) loadcard();
        });
      } catch (e) {
        print(e);
      }
    }
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
        leading: const SizedBox(
          width: 10,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyPage()),
              );
            },
          ),
        ],
      ),
      body: Column(children: [
        Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "서울시꿈나무카드",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 50),
                      const Text("서울시님, 안녕하세요."),
                      const SizedBox(height: 10),
                      result != null
                          ? const Text("잔액조회 및 이용내역을 확인해보세요.")
                          : const Text("지금 바로 서울시꿈나무카드를 등록해보세요."),
                      const SizedBox(height: 30),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDF8EA),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFFFC842),
                            width: 1,
                          ),
                        ),
                        child: result != null
                            ? Container(
                                // child: Text("잔액 : ${cardcontent?[0].usage}"),
                                )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FloatingActionButton(
                                      backgroundColor: const Color(0xFfFFC842),
                                      elevation: 0,
                                      child: const Icon(Icons.add,
                                          color: Colors.black, size: 30),
                                      onPressed: () async {
                                        setState(() {
                                          //isCard = true;
                                        });
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const AddCardPage();
                                        }));
                                        loadData();
                                      }),
                                  const SizedBox(height: 10),
                                  const Text("서울시꿈나무 카드 등록",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  const Text("*본인 혹은 자녀 명의 카드만 등록 가능합니다.",
                                      style: TextStyle(
                                          color: Color(0xFF858585),
                                          fontSize: 12)),
                                ],
                              ),
                      ),
                      const SizedBox(height: 30),
                    ]))),
        Container(height: 5, color: const Color(0xFFE9E9E9)),
        result != null ? const Text("카드있음") : const SizedBox(),
      ]),
    );
  }
}
