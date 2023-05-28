import 'package:flutter/material.dart';

import 'signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String id = '';
    String password = '';
    String passwordCheck = '';
    String name = '';

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
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.58,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: '이메일 입력',
                                      hintText: '이메일을 입력하세요',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '이메일을 입력하세요';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      id = String.fromCharCodes(
                                          value!.codeUnits);
                                    },
                                  )),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width * 0.3,
                                        60)),
                                onPressed: () {},
                                child: const Text('중복확인'),
                              ),
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
                              labelText: '비밀번호 입력',
                              hintText: '비밀번호를 입력하세요',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '비밀번호를 입력하세요';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              password = String.fromCharCodes(value!.codeUnits);
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: '비밀번호 재입력',
                              hintText: '비밀번호를 재입력하세요',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '비밀번호를 재입력하세요';
                              }
                              return null;
                            },
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
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.58,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: '닉네임 입력',
                                      hintText: '닉네임을 입력하세요',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '닉네임을 입력하세요';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      name = String.fromCharCodes(
                                          value!.codeUnits);
                                    },
                                  )),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width * 0.3,
                                        60)),
                                onPressed: () {},
                                child: const Text('중복확인'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width, 55)),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                print('id: $id, password: $password');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignUp2()));
                              }
                            },
                            child: const Text('다음'),
                          ),
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
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "회원가입 완료!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text("지금부터 어깨동무에서",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
                const Text("언제 어디서나 쉽고 빠르게 사용해보세요!",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
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
              ],
            ))));
  }
}
