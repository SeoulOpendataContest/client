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
            body: Center(
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
                        const Text("지금 바로 서울시꿈나무카드를 등록해보세요."),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                              Size(MediaQuery.of(context).size.width, 50),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              isCard = true;
                            });
                          },
                          child: const Text(
                            '카드 추가하기',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ),
                      ],
                    ))));
  }
}
