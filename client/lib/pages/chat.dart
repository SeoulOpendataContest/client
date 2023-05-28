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
  //
  List<String> question = [
    '사용 가능한 음식점은 어디인가요?',
    '그럼 꿈나무 카드로 타구에서는 사용가능한가요?',
    '꿈나무 카드를 가지고 가족들이 같이 사용해도 되나요?',
    '꿈나무 카드 분실 또는 훼손되어 사용하지 못하는 경우 어떻게 해야 하나요?',
    '꿈나무 카드 금액을 월말까지 쓰지 못했는데 나머지 쓰지 못한 금액을 다음달에 모아서 쓸 수 있나요?',
    '온라인 결제 어떻게 하나요?'
  ];
  List<String> answer = [
    'CU, GS25, 세븐일레븐(24시간 편의점) 그리고 거주지 동과 상관없이 꿈나무카드 가맹 음식점 어디서나 이용하실 수 있습니다. 단, CU,GS25,세븐일레븐에서는 도시락이나 김밥류만 급식 하실 수 있습니다.',
    '서울시내 꿈나무 카드 가맹 음식점이라면 어디서나 사용하실 수 있습니다. 구청 홈페이지나 해당동 주민센터로 문의하셔서 가까운 꿈나무카드 가맹음식점을 확인하실 수 있습니다.',
    '안됩니다. 아동의 건강한 성장을 위하여 꿈나무 카드 발급 대상인 결식우려 아동에게 급식비가 지원되는 것으로 가족들이 같이 쓰는 부가급여 성격의 지원금이 아닙니다.',
    '분실시 동주민센터 아동급식 담당에게 분실 사항을 신고하시고 다시 발급 받으시고, 훼손의 경우 꿈나무 카드를 반납하시고 다시 발급 받으시기 바랍니다.',
    '다음달로 이월되지 않으며, 당월 미사용 잔액은 구청의 꿈나무카드 모계좌로 자동 반납됩니다.',
    '구글 PLay 스토어 혹은 앱스토어에서 GS25 나만의 냉장고 앱을 설치하시면 됩니다. GS25 나만의 냉장고 앱에서 [예약주문] 기능을 이용해 고품질의 도시락, 김밥 등 먹거리를 선택하고, 원하는 시간과 편의점을 입력한 후 결제 시 꿈나무카드를 등록하면 20% 할인을 받을 수 있습니다.'
  ];
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
          'asset/chating/chat${index.toString()}.png',
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.width * 0.3,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration deco = BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: const Color(0xFFFFC842),
      ),
    );
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
                        Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFFFC842),
                              ),
                            ),
                            margin: const EdgeInsets.only(left: 20),
                            child: Container(
                              height: 120,
                              alignment: Alignment.center,
                              child: const Text(
                                '안녕하세요! 어깨동무입니다.\n궁금하신 점을 질문해주시면\n답변해드릴게요!\n\n아래의 궁금한 점을 클릭해주세요.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                                strutStyle: StrutStyle(
                                  height: 1.5,
                                ),
                              ),
                            )),
                        const SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.width * 0.7,
                          decoration: deco,
                          alignment: Alignment.center,
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
                        const SizedBox(height: 10),
                        if (questionIndex > 0)
                          Column(
                            children: [
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  decoration: deco,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: Container(
                                    height: 120,
                                    alignment: Alignment.center,
                                    child: Text(
                                      question[questionIndex - 1],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                      strutStyle: StrutStyle(
                                        height: 1.5,
                                      ),
                                    ),
                                  )),
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
                              Container(
                                height: 120,
                                alignment: Alignment.center,
                                decoration: deco,
                                child: Text(
                                  answer[questionIndex - 1],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                  strutStyle: StrutStyle(
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ]),
                    )))));
  }
}
