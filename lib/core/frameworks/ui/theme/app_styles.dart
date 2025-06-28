import 'package:flutter/material.dart';

abstract class AppStyles {
  static const pink = Color(0xffe91e63);

  static const lightGrey1 = Color(0xfff2f2f7);
  static const lightGrey2 = Color(0xffe5e5ea);
  static const lightGrey3 = Color(0xffdddde2);
  static const lightGrey4 = Color(0xffc3c4c6);
  static const lightGrey5 = Color(0xffb4b4b4);

  static const grey1 = Color(0xff98989f);
  static const grey2 = Color(0xff8a8a8e);
  static const grey3 = Color(0xff757575);
  static const grey4 = Color(0xff6d6d72);
  static const grey5 = Color(0xff5a5a5f);

  static const darkGrey1 = Color(0xff3e3e41);
  static const darkGrey2 = Color(0xff2b2c2e);
  static const darkGrey3 = Color(0xff1c1c1e);
  static const darkGrey4 = Color(0xff121212);

  static const lightGreen = Color(0xff66d26c);
  static const green = Color(0xff4caf50);

  static const black = Color(0xff000000);
  static const white = Color(0xffffffff);

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
