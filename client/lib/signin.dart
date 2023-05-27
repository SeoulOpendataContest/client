import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'signup.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});
  @override
  SigninState createState() => SigninState();
}

class SigninState extends State<Signin> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String id = '';
    String password = '';

    return Scaffold(
        body: Form(
            key: formKey,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(children: [
                          const SizedBox(height: 80),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: const Text(
                              '로그인',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
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
                                print('id: $id, password: $password');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MainApp()));
                              }
                            },
                            child: const Text('로그인'),
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
