import 'dart:ui';

enum ColorConstants {
  timerCardDark(0xFF424242),
  timerCardLight(0xFFE0E0E0),
  scaffoldBackGround(0xFFE0E0E0),
  ;

  final int value;
  const ColorConstants(this.value);

  Color get color => Color(value);
}
