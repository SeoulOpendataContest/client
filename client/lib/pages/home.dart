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
  int remainingDays =
      DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day -
          DateTime.now().day;

  List<CardContent>? mycard;
  List<CardContent>? result = [];
  List<CardContent>? cardcontent = [];

  late AnimationController controller;

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken') ?? '';
    if (accessToken != '') {
      try {
        final dio = Dio()..interceptors.add(CustomLogInterceptor());
        final restClient = ClientPerson(dio);
        final response = await restClient.getCardList(jsondata: {
          "email": accessToken,
        });
        setState(() {
          result = response;

          if (result?.isNotEmpty ?? false) {
            getcard();
          }
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
        final response = await restClient.updateCard(jsondata: {
          'cardNumber': '${result?[0].cardNumber}',
          'cardYear': '${result?[0].cardYear}',
          'cardMonth': '${result?[0].cardMonth}',
          'cardCVC': '${result?[0].cardCVC}',
        });
        setState(() {
          mycard = response;
          if (mycard != null) loadcard();
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
        final response = await restClient.checkUsage(jsondata: {
          "email": accessToken,
          "cardNumber": "${mycard?[0].cardNumber}"
        });
        setState(() {
          cardcontent = response;
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
                height: MediaQuery.of(context).size.height * 0.45,
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
                      (result?.isNotEmpty ?? false)
                          ? const Text("잔액조회 및 이용내역을 확인해보세요.")
                          : const Text("지금 바로 서울시꿈나무카드를 등록해보세요."),
                      const SizedBox(height: 30),
                      Container(
                        alignment: Alignment.center,
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
                        child: (result?.isNotEmpty ?? false)
                            ? (cardcontent?.isNotEmpty ?? false)
                                ? Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                        Row(
                                          children: [
                                            const SizedBox(width: 10),
                                            Image.asset(
                                              "asset/bank/신한은행로고.png",
                                              width: 30,
                                              height: 30,
                                            ),
                                            const Text("서울시님의 꿈나무카드",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                ))
                                          ],
                                        ),
                                        Text(
                                          "${cardcontent?[0].balance}",
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text("일부 금액 사용량이 "),
                                            Text("$remainingDays일 ",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF42CE00))),
                                            const Text("남았어요!")
                                          ],
                                        ),
                                        const SizedBox(height: 0),
                                      ])
                                : // loading circle
                                const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator(
                                              color: Color(0xFF42CE00))),
                                      SizedBox(height: 10),
                                      Text("잔액 조회 중입니다.",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 10),
                                      Text("잠시만 기다려주세요.",
                                          style: TextStyle(
                                              color: Color(0xFF858585),
                                              fontSize: 12)),
                                    ],
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
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const AddCardPage();
                                        }));
                                        setState(() {
                                          loadData();
                                        });
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
        result?.isNotEmpty ?? false
            ? Column(
                children: [
                  // SizedBox(
                  //   height: 50,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       // setting icon
                  //       const Icon(
                  //         Icons.settings_outlined,
                  //         color: Color(0xFF4D4D4D),
                  //         size: 20,
                  //       ),
                  //       TextButton(
                  //         onPressed: () {},
                  //         child: const Text("조회설정",
                  //             style: TextStyle(
                  //                 fontSize: 15,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Color(0xFF4D4D4D))),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.27,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ListView.builder(
                        itemCount: cardcontent?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${cardcontent?[index].usage}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF4D4D4D))),
                                    const SizedBox(height: 5),
                                    Text("${cardcontent?[index].priceTime}",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF605C5C))),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Text("-${cardcontent?[index].price}",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF858585))),
                              ],
                            ),
                          );
                        },
                      )),
                ],
              )
            : Container(),
      ]),
    );
  }
}
