import 'dart:ui';

enum ColorConstants {
  timerCardDark(0xFF424242),
  timerCardLight(0xFFE0E0E0),
  //deeppurple color
  scaffoldBackGround(0xFF673AB7),
  scaffoldBackGroundDark(0x000);

  final int value;
  const ColorConstants(this.value);

  Color get color => Color(value);
}
