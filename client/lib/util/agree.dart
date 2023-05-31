import 'package:flutter/material.dart';

Widget agreeCheckBox(context, title, tmp, onChanged) {
  return Row(children: [
    SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: CheckboxListTile(
          title: Text(title, style: const TextStyle(fontSize: 12)),
          value: tmp,
          checkboxShape: const CircleBorder(),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (bool? value) {
            onChanged(value);
          },
        )),
    TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(title),
                  content: const Text('약관 내용이 들어갈 공간입니다.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, "OK");
                        },
                        child: const Text('확인',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF999999))))
                  ],
                );
              });
        },
        child: const Text('보기',
            style: TextStyle(fontSize: 12, color: Color(0xFF999999)))),
  ]);
}
