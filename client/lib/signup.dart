import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:client/util/alert.dart';
import 'package:client/util/agree.dart';

import 'signin.dart';
import 'api/client.dart';
import 'api/log_interceptor.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  bool idCheck = false;
  bool nameCheck = false;
  bool agreeAllCheck = false;
  List<bool> agreeCheck = [false, false, false];

  @override
  Widget build(BuildContext context) {
    String id = '';
    String password = '';
    String passwordCheck = '';
    String name = '';

    List<String> agreeList = [
      '이용약관 동의 (필수)',
      '개인정보 수집 및 이용 동의 (필수)',
      '위치 정보 이용 동의 (필수)'
    ];

    void CheckId(id) async {
      try {
        final dio = Dio()..interceptors.add(CustomLogInterceptor());
        final restClient = ClientPerson(dio);
        final response = await restClient.checkEmail(jsondata: {
          "email": id,
        });
        setState(() {});
      } catch (e) {
        print(e);
      }
    }

    void CheckName(name) async {
      try {
        final dio = Dio()..interceptors.add(CustomLogInterceptor());
        final restClient = ClientPerson(dio);
        final response = await restClient.checkNickname(jsondata: {
          "email": id,
        });
        setState(() {
          idCheck = true;
        });
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shape: const Border(bottom: BorderSide(color: Color(0xFFABABAB))),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('회원가입',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Form(
            key: formKey,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const Row(
                            children: [
                              Text(
                                "아이디",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "*",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.58,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: '이메일을 입력하세요',
                                      helperText: '사용 가능한 특수문자는 (_/-/@/.)입니다.',
                                      helperStyle: TextStyle(
                                        fontSize: 10,
                                      ),
                                      errorStyle: TextStyle(
                                        fontSize: 10,
                                      ),
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '이메일을 입력하세요';
                                      } else if (value.contains(
                                          RegExp(r"[^a-zA-Z0-9@._/-]"))) {
                                        return '사용 가능한 특수문자는 (_/-/@/.)입니다.';
                                      }
                                      idCheck = true;
                                      return null;
                                    },
                                    autovalidateMode: AutovalidateMode.always,
                                    onSaved: (value) {
                                      id = String.fromCharCodes(
                                          value!.codeUnits);
                                    },
                                  )),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              Column(children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: idCheck
                                          ? const Color(0xFFFFC842)
                                          : const Color(0xFFFFE6A8),
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width *
                                              0.3,
                                          60)),
                                  onPressed: () async {
                                    formKey.currentState!.save();
                                    CheckId(id);
                                    idCheck
                                        ? basicAlertShow(
                                            context,
                                            AlertType.success,
                                            "아이디",
                                            "사용가능한 아이디입니다.",
                                            const SizedBox(), () {
                                            Navigator.pop(context);
                                          })
                                        : basicAlertShow(
                                            context,
                                            AlertType.error,
                                            "아이디",
                                            "이미 사용중인 이메일입니다.",
                                            const SizedBox(), () {
                                            Navigator.pop(context);
                                          });
                                  },
                                  child: const Text('중복확인',
                                      style: TextStyle(fontSize: 12)),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ])
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              Text(
                                "비밀번호",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "*",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: '비밀번호를 입력하세요',
                              helperText:
                                  '영문,숫자,특수문자 중 3가지 이상 의 문자조합 8-32자로 입력해주세요.',
                              helperStyle: TextStyle(
                                fontSize: 10,
                              ),
                              errorStyle: TextStyle(
                                fontSize: 10,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '비밀번호를 입력하세요';
                              }
                              // 영문,숫자,특수문자 중 2가지 이상 의 문자조합 8-32자로 입력해주세요.
                              if (!value.contains(RegExp(
                                  r"^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,32}$"))) {
                                return '영문,숫자,특수문자 중 3가지 이상 의 문자조합 8-32자로 입력해주세요.';
                              }
                              return null;
                            },
                            autovalidateMode: AutovalidateMode.always,
                            onSaved: (value) {
                              password = String.fromCharCodes(value!.codeUnits);
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: '비밀번호를 재입력하세요',
                              errorStyle: TextStyle(
                                fontSize: 10,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '비밀번호를 재입력하세요';
                              }
                              return null;
                            },
                            autovalidateMode: AutovalidateMode.always,
                            onSaved: (value) {
                              passwordCheck =
                                  String.fromCharCodes(value!.codeUnits);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              Text(
                                "닉네임",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "*",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.58,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: '닉네임을 입력하세요',
                                      helperText: '20자 이내로 입력해주세요.',
                                      helperStyle: TextStyle(
                                        fontSize: 10,
                                      ),
                                      errorStyle: TextStyle(
                                        fontSize: 10,
                                      ),
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '닉네임을 입력하세요';
                                      }
                                      if (value.length > 20) {
                                        return '20자 이내로 입력해주세요.';
                                      }
                                      nameCheck = true;
                                      return null;
                                    },
                                    autovalidateMode: AutovalidateMode.always,
                                    onSaved: (value) {
                                      name = String.fromCharCodes(
                                          value!.codeUnits);
                                    },
                                  )),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              Column(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: nameCheck
                                            ? const Color(0xFFFFC842)
                                            : const Color(0xFFFFE6A8),
                                        elevation: 0,
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                            60)),
                                    onPressed: () async {
                                      formKey.currentState!.save();
                                      CheckName(nameCheck);
                                      nameCheck
                                          ? basicAlertShow(
                                              context,
                                              AlertType.success,
                                              "닉네임",
                                              "사용가능한 닉네임입니다.",
                                              const SizedBox(), () {
                                              Navigator.pop(context);
                                            })
                                          : basicAlertShow(
                                              context,
                                              AlertType.error,
                                              "닉네임",
                                              "이미 사용중인 닉네임입니다.",
                                              const SizedBox(), () {
                                              Navigator.pop(context);
                                            });
                                    },
                                    child: const Text('중복확인',
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),

                          // agree all button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: agreeAllCheck
                                    ? const Color(0xFFFFC842)
                                    : const Color(0xFFFFE6A8),
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width, 55)),
                            onPressed: () {
                              setState(() {
                                for (int i = 0; i < agreeCheck.length; i++) {
                                  agreeCheck[i] = true;
                                }
                                agreeAllCheck = true;
                              });
                            },
                            child: const Text('모든 약관 동의',
                                style: TextStyle(fontSize: 12)),
                          ),

                          for (int i = 0; i < agreeList.length; i++)
                            agreeCheckBox(
                              context,
                              agreeList[i],
                              agreeCheck[i],
                              (value) {
                                setState(() {
                                  agreeCheck[i] = value!;

                                  bool check = true;
                                  for (int i = 0; i < agreeCheck.length; i++) {
                                    if (agreeCheck[i] == false) {
                                      check = false;
                                      break;
                                    }
                                  }
                                  agreeAllCheck = check;
                                });
                              },
                            ),

                          ElevatedButton(
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
                                var jsondata = {
                                  "email": id,
                                  "password": password,
                                  "nickname": name,
                                  "checkedPassword": passwordCheck
                                };

                                restClient
                                    .signUp(jsondata: jsondata)
                                    .then((value) {});

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignUp2()));
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
                          ),
                          const SizedBox(height: 30)
                        ]))))));
  }
}

class SignUp2 extends StatefulWidget {
  const SignUp2({super.key});
  @override
  SignUp2State createState() => SignUp2State();
}

class SignUp2State extends State<SignUp2> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFDF8EA),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: const Color(0xFFFDF8EA),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "회원가입 완료!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text("지금부터 어깨동무에서",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Text("언제 어디서나 쉽고 빠르게 사용해보세요!",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ]),
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'asset/character/카드등록완료.png',
                  width: MediaQuery.of(context).size.width,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(MediaQuery.of(context).size.width * 0.95, 55)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Signin()));
                  },
                  child: const Text('완료'),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ))));
  }
}
