import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';

void basicAlertShow(BuildContext context, AlertType type, String title,
    String? desc, Function() onPressed) {
  Alert(
    context: context,
    type: type,
    title: title,
    desc: desc,
    style: const AlertStyle(
      titleStyle: TextStyle(color: Colors.black, fontSize: 15),
      descStyle: TextStyle(color: Colors.grey, fontSize: 12),
    ),
    buttons: [
      DialogButton(
        onPressed: () => onPressed(),
        color: const Color(0xFFFFC842),
        child: const Text(
          "확인",
          style: TextStyle(color: Colors.black, fontSize: 13),
        ),
      )
    ],
  ).show();
}
