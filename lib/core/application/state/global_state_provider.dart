import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_time_tracker/core/application/Theme/custom_theme_mode.dart';
import 'package:task_time_tracker/core/application/constants/color_constants.dart';
import 'package:task_time_tracker/infrastructure/cache/hive_cache_manager.dart';

class ThemeStateProvider extends ChangeNotifier {
  String key = 'darkMode';
  String? _darkMode;
  late CustomThemeMode _themeMode;

  ThemeStateProvider() {
    _darkMode = HiveCacheManager.instance.hive?.get(key) as String? ??
        CustomThemeMode.light.name;
    _themeMode = _darkMode == CustomThemeMode.dark.name
        ? CustomThemeMode.dark
        : CustomThemeMode.light; //default
  }
  CustomThemeMode get themeMode => _themeMode;

  ThemeData get theme =>
      _themeMode == CustomThemeMode.light ? _lightTheme : _darkTheme;
  bool isLightTheme() => _themeMode == CustomThemeMode.light;

  void setThemeMode() {
    _themeMode = _themeMode.name == CustomThemeMode.light.name
        ? CustomThemeMode.dark
        : CustomThemeMode.light;
    HiveCacheManager.instance.hive!.put('darkMode', _themeMode.name);
    notifyListeners();
  }

  ThemeData get _darkTheme => ThemeData.dark().copyWith(
      cardColor: ColorConstants.timerCardDark.color,
      scaffoldBackgroundColor: ColorConstants.scaffoldBackGroundDark.color,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            backgroundColor: ColorConstants.darkBlue.color,
            foregroundColor: Colors.white),
      ));

  ThemeData get _lightTheme => ThemeData.light().copyWith(
      cardColor: ColorConstants.timerCardLight.color,
      scaffoldBackgroundColor: ColorConstants.scaffoldBackGround.color,
      appBarTheme:
          AppBarTheme(backgroundColor: ColorConstants.customPurple.color),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            backgroundColor: ColorConstants.customPurple.color,
            foregroundColor: Colors.white),
      ));
}
