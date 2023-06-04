import 'package:flutter/material.dart';

// make card widget
Widget cardPage(context, a1) {
  bool a2 = false;
  if (a1) a2 = true;
  bool a3 = false;

  a1
      ? a2
          ? (a3 = false)
          : (a3 = true)
      : a3 = true;
  return Container();
}
