import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  // chat content
  int questionIndex = 0;
  DateTime now = DateTime.now();

  Widget questionButton(int index) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            questionIndex = index;
            now = DateTime.now();
          });
        },
        child: Image.asset(
          //'asset/chat/${index.toString()}.png',
          'asset/chat/1.png',
          //'asset/character/카드등록완료.png',

          width: MediaQuery.of(context).size.width * 0.2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shape: const Border(bottom: BorderSide(color: Color(0xFFABABAB))),
          elevation: 0,
          leading: const SizedBox(
            width: 10,
          ),
          title: const Text(
            '챗봇 서비스',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w900, fontSize: 17),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  questionIndex = 0;
                  now = DateTime.now();
                });
              },
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: Container(
          color: const Color(0xFFFDF8EA),
          child: Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.92,
                child: SingleChildScrollView(
                  child: Column(children: [
                    if (questionIndex == 0)
                      Column(children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.82,
                          color: const Color(0xFFFFFFFF),
                          margin: const EdgeInsets.only(top: 20),
                          child: const Text(
                            '안녕하세요! 어깨동무입니다.\n궁금하신 점을 질문해주시면\n답변해드릴게요!\n\n아래의 궁금한 점을 클릭해주세요.',
                            style: TextStyle(color: Colors.black, fontSize: 13),
                            strutStyle: StrutStyle(
                              height: 1.5,
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  questionButton(1),
                                  questionButton(2),
                                  questionButton(3),
                                ],
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    questionButton(4),
                                    questionButton(5),
                                    questionButton(6),
                                  ]),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Text(
                            " ${now.hour}:${now.minute}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ])
                    else
                      Text("dd")
                  ]),
                )),
          ),
        ));
  }
}
