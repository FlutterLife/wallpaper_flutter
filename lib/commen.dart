import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

mixin Appcolor {
  static const Color bgColor = Color(0xff27272A);
  // static const Color bgColor = Color(0xFF707070);
}


showTostMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 12.0);
}
