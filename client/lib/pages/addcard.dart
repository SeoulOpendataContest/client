import 'package:flutter/material.dart';
import 'package:credit_card_scanner/credit_card_scanner.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:client/util/agree.dart';
import 'package:client/util/alert.dart';

import '../api/client.dart';
import '../api/log_interceptor.dart';

import 'home.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);
  @override
  AddCardPageState createState() => AddCardPageState();
}

class AddCardPageState extends State<AddCardPage> {
  bool isCard = false;
  CardDetails? _cardDetails;
  final formKey = GlobalKey<FormState>();

  bool agreeAllCheck = false;
  List<bool> agreeCheck = [false, false, false];

  String cardNumber = '';
  String cardExpireDate = '';
  String cardCVC = '';
  String cardName = '';
  String email = '';
  String accessToken = '';
  String result = '';

  CardScanOptions scanOptions = const CardScanOptions(
    scanCardHolderName: true,
    // enableDebugLogs: true,
    validCardsToScanBeforeFinishingScan: 5,
    possibleCardHolderNamePositions: [
      CardHolderNameScanPosition.aboveCardNumber,
    ],
  );

  Future<void> scanCard() async {
    final CardDetails? cardDetails =
        await CardScanner.scanCard(scanOptions: scanOptions);
    if (!mounted || cardDetails == null) return;
    setState(() {
      _cardDetails = cardDetails;
    });
  }

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken') ?? '';
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
            leading: const SizedBox(),
            shape: const Border(bottom: BorderSide(color: Color(0xFFABABAB))),
            title: const Text(
              '카드 정보',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 10),
            ]),
        body: SingleChildScrollView(
            child: Form(
                key: formKey,
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFFFC842),
                        ),
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.credit_card, color: Colors.black),
                              Text("  카드 정보를 입력해주세요",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ]),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFABABAB)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.68,
                                      margin: const EdgeInsets.only(left: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text('카드 번호',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold)),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  '0000 - 0000 - 0000 - 0000',
                                              hintStyle:
                                                  TextStyle(fontSize: 12),
                                            ),
                                            autovalidateMode:
                                                AutovalidateMode.always,
                                            onSaved: (value) {
                                              cardNumber = String.fromCharCodes(
                                                  value!.codeUnits);
                                            },
                                            initialValue: cardNumber,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 30,
                                      color: const Color(0xFFABABAB),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.camera_alt),
                                          onPressed: () async {
                                            await scanCard();
                                            if (_cardDetails != null) {
                                              setState(() {
                                                cardNumber =
                                                    _cardDetails!.cardNumber;
                                                cardExpireDate =
                                                    _cardDetails!.expiryDate;
                                              });
                                            }
                                          },
                                        ),
                                        const Text(
                                          "카드 스캔",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ]),
                              const Divider(
                                height: 1,
                                thickness: 1,
                                indent: 0,
                                endIndent: 0,
                                color: Color(0xFFABABAB),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      margin: const EdgeInsets.only(left: 15),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text('유효기간',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              child: TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'MM/YY',
                                                  hintStyle:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                autovalidateMode:
                                                    AutovalidateMode.always,
                                                onSaved: (value) {
                                                  cardExpireDate =
                                                      String.fromCharCodes(
                                                          value!.codeUnits);
                                                },
                                              ),
                                            ),
                                          ])),
                                  // divider
                                  Container(
                                    width: 1,
                                    height: 30,
                                    color: const Color(0xFFABABAB),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text('CVC',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: '000',
                                              hintStyle:
                                                  TextStyle(fontSize: 12),
                                            ),
                                            autovalidateMode:
                                                AutovalidateMode.always,
                                            onSaved: (value) {
                                              cardCVC = String.fromCharCodes(
                                                  value!.codeUnits);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                      const SizedBox(height: 30),
                      Container(height: 8, color: const Color(0xFFE9E9E9)),
                      const SizedBox(height: 30),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: agreeAllCheck
                              ? const Color(0xFFFFC842)
                              : const Color(0xFFD6D6D6),
                        ),
                        // information agree checkbox
                        child: const Text("전체 약관 동의",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFABABAB)),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                agreeCheckBox(
                                  context,
                                  '어깨동무 개인(신용)정보 수집 및 이용 동 (필수)',
                                  agreeCheck[0],
                                  (value) {
                                    setState(() {
                                      agreeCheck[0] = value!;

                                      bool check = true;
                                      for (int i = 0;
                                          i < agreeCheck.length;
                                          i++) {
                                        if (agreeCheck[i] == false) {
                                          check = false;
                                          break;
                                        }
                                      }
                                      agreeAllCheck = check;
                                    });
                                  },
                                ),
                                agreeCheckBox(
                                  context,
                                  '어깨동무→신한카드 개인(신용)정보 제공 동의 (필수)',
                                  agreeCheck[1],
                                  (value) {
                                    setState(() {
                                      agreeCheck[1] = value!;

                                      bool check = true;
                                      for (int i = 0;
                                          i < agreeCheck.length;
                                          i++) {
                                        if (agreeCheck[i] == false) {
                                          check = false;
                                          break;
                                        }
                                      }
                                      agreeAllCheck = check;
                                    });
                                  },
                                ),
                                agreeCheckBox(
                                  context,
                                  '신한카드→어깨동무 개인(신용)정보 제공 동의 (필수)',
                                  agreeCheck[2],
                                  (value) {
                                    setState(() {
                                      agreeCheck[2] = value!;

                                      bool check = true;
                                      for (int i = 0;
                                          i < agreeCheck.length;
                                          i++) {
                                        if (agreeCheck[i] == false) {
                                          check = false;
                                          break;
                                        }
                                      }
                                      agreeAllCheck = check;
                                    });
                                  },
                                )
                              ])),
                      // Textformfield of card's nickname
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFFFFC842),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: agreeAllCheck
                                    ? const Color(0xFFFFC842)
                                    : const Color(0xFFFFE6A8),
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width, 55)),
                            onPressed: () {
                              if (formKey.currentState!.validate() &&
                                  agreeAllCheck) {
                                formKey.currentState!.save();

                                final dio = Dio()
                                  ..interceptors.add(CustomLogInterceptor());
                                final restClient = ClientPerson(dio);
                                dynamic jsondata;
                                basicAlertShow(
                                    context,
                                    AlertType.info,
                                    '카드 등록 완료',
                                    '카드의 별명을 설정해서 보다 편리하게 카드 관리를 해보세요!',
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height: 50,
                                        margin: const EdgeInsets.only(top: 30),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: const Color(0xFFABABAB)),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                alignment: Alignment.center,
                                                child: const Text('카드 별칭',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            SizedBox(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              child: TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '카드 별칭을 입력해주세요.',
                                                  hintStyle:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                autovalidateMode:
                                                    AutovalidateMode.always,
                                                onSaved: (value) {
                                                  cardName =
                                                      String.fromCharCodes(
                                                          value!.codeUnits);
                                                },
                                              ),
                                            ),
                                          ],
                                        )),
                                    () => {
                                          if (formKey.currentState!.validate())
                                            {
                                              formKey.currentState!.save(),
                                              jsondata = {
                                                "email": accessToken,
                                                "cardNumber": cardNumber,
                                                "cardYear":
                                                    "20${cardExpireDate.substring(3, 5)}",
                                                "cardMonth": cardExpireDate
                                                    .substring(0, 2),
                                                "cardCVC": cardCVC,
                                                "cardName": cardName
                                              },
                                              restClient
                                                  .signUpCard(
                                                      jsondata: jsondata)
                                                  .then((value) {}),
                                              // navigator pop 2 page
                                              Navigator.pop(context),
                                              Navigator.pop(context)
                                            }
                                        }); // 회원가입
                              } else if (agreeAllCheck == false) {
                                basicAlertShow(
                                    context,
                                    AlertType.error,
                                    "이용약관 동의",
                                    "회원가입 시 이용약관 동의와 개인정보 수집 및 이용동의는 필수 입니다. 이용약관에 동의해주세요.",
                                    const SizedBox(), () {
                                  Navigator.pop(context);
                                });
                                //
                              }
                            },
                            child: const Text('다음'),
                          )),
                    ],
                  ),
                ))));
  }
}
