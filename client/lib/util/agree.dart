import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

Widget agreeCheckBox(context, title, tmp, onChanged) {
  String text = '';
  Future<String> loadTextAsset() async {
    return await rootBundle.loadString('asset/agree/$title.txt');
  }

  loadTextAsset().then((value) {
    text = value;
  });

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
                  content: SingleChildScrollView(child: Text(text)),
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
