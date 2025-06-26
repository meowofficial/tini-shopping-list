import 'package:flutter/material.dart';

abstract class AppStyles {
  static const Color pink = Color(0xffe91e63);

  static const Color lightGrey1 = Color(0xfff2f2f7);
  static const Color lightGrey2 = Color(0xffe5e5ea);
  static const Color lightGrey3 = Color(0xffdddde2);
  static const Color lightGrey4 = Color(0xffc3c4c6);
  static const Color lightGrey5 = Color(0xffb4b4b4);

  static const Color grey1 = Color(0xff98989f);
  static const Color grey2 = Color(0xff8a8a8e);
  static const Color grey3 = Color(0xff757575);
  static const Color grey4 = Color(0xff6d6d72);
  static const Color grey5 = Color(0xff5a5a5f);

  static const Color darkGrey1 = Color(0xff3e3e41);
  static const Color darkGrey2 = Color(0xff2b2c2e);
  static const Color darkGrey3 = Color(0xff1c1c1e);
  static const Color darkGrey4 = Color(0xff121212);

  static const Color lightGreen = Color(0xff66d26c);
  static const Color green = Color(0xff4caf50);

  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);

  static const fontFamily = 'Inter';

  static const baseTextStyle = TextStyle(
    inherit: false,
    textBaseline: TextBaseline.alphabetic,
    fontFamily: fontFamily,
    height: 1.0,
    letterSpacing: 0,
    decoration: TextDecoration.none,
    color: Colors.red,
  );
}
