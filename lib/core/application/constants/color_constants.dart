import 'dart:ui';

import 'package:flutter/material.dart';

enum ColorConstants {
  timerCardDark(0xFF424242),
  timerCardLight(0xFFE0E0E0),
  //deeppurple color
  scaffoldBackGround(0xFFFFFFFF),
  scaffoldBackGroundDark(0x000),
  darkBlue(0xFF1B143F),
  customPurple(0xFF673AB7);

  final int value;
  const ColorConstants(this.value);

  Color get color => Color(value);
}
