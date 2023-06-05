import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:client/util/alert.dart';

import 'app.dart';
import 'signup.dart';
import 'api/client.dart';
import 'api/log_interceptor.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});
  @override
  SigninState createState() => SigninState();
}

class SigninState extends State<Signin> {
  final formKey = GlobalKey<FormState>();
  final prefs = SharedPreferences.getInstance();

  void setString(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', accessToken);
  }

  @override
  Widget build(BuildContext context) {
    String id = '';
    String password = '';
    bool login = false;

    return Scaffold(
        body: Form(
            key: formKey,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(children: [
                          const SizedBox(height: 160),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: const Text(
                              '로그인',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: '아이디',
                              hintText: '아이디(이메일)를 입력해주세요',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '아이디를 입력하세요';
                              }
                              return null;
                            },
                            autovalidateMode: AutovalidateMode.always,
                            onSaved: (value) {
                              id = String.fromCharCodes(value!.codeUnits);
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: '비밀번호',
                              hintText: '비밀번호를 입력하세요',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '비밀번호를 입력하세요';
                              }
                              return null;
                            },
                            obscureText: true,
                            obscuringCharacter: '*',
                            autovalidateMode: AutovalidateMode.always,
                            onSaved: (value) {
                              password = String.fromCharCodes(value!.codeUnits);
                            },
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

                                final dio = Dio()
                                  ..interceptors.add(
                                    CustomLogInterceptor(),
                                  );
                                final restClient = ClientPerson(dio);
                                var jsondata = {
                                  "email": id,
                                  "password": password,
                                };
                                restClient
                                    .login(jsondata: jsondata)
                                    .then((value) {
                                  setState(() {
                                    login = value.success;
                                    setString(id);
                                    if (login) {
                                      basicAlertShow(
                                          context,
                                          AlertType.success,
                                          "로그인 성공",
                                          "어깨동무에 오신 것을 환영합니다.",
                                          const SizedBox(), () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const MainApp()));
                                      });
                                    } else {
                                      basicAlertShow(
                                          context,
                                          AlertType.error,
                                          "로그인 실패",
                                          value.error?.message,
                                          const SizedBox(), () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Signin()));
                                      });
                                    }
                                  });
                                });
                              }
                            },
                            child: const Text('로그인',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(height: 40),
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const SignUp();
                                    }));
                                  },
                                  child: const Text('회원가입',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.underline))),
                            ],
                          )
                        ]))))));
  }
}
