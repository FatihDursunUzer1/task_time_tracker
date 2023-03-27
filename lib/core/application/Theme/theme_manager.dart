import 'package:flutter/material.dart';
import 'package:task_time_tracker/core/application/constants/color_constants.dart';

class ThemeManager {
  static ThemeManager? _instance;
  ThemeManager._();
  static ThemeManager get instance => _instance ?? ThemeManager._();

  CustomThemeMode _themeMode = CustomThemeMode.light; //default
  CustomThemeMode get themeMode => _themeMode;
  ThemeData get theme =>
      _themeMode == CustomThemeMode.light ? _lightTheme : _darkTheme;
  bool isLightTheme() => _themeMode == CustomThemeMode.light;
  void setThemeMode() {
    _themeMode = _themeMode.name == CustomThemeMode.light.name
        ? CustomThemeMode.dark
        : CustomThemeMode.light;

    print("ThemeManager: setThemeMode: ${_themeMode.name}");
  }

  ThemeData get _darkTheme =>
      ThemeData.dark().copyWith(cardColor: ColorConstants.timerCardDark.color);
  ThemeData get _lightTheme => ThemeData.light()
      .copyWith(cardColor: ColorConstants.timerCardLight.color);
}

enum CustomThemeMode { light, dark }
