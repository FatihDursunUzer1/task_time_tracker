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
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.black,
            selectedIconTheme: IconThemeData(
                color: ColorConstants.customPurple.color, size: 32)),
        inputDecorationTheme: InputDecorationTheme(
            contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
            suffixIconColor: ColorConstants.darkBlue.color,
            labelStyle: TextStyle(color: ColorConstants.darkBlue.color),
            focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: ColorConstants.customPurple.color))),
        cardColor: ColorConstants.timerCardDark.color,
        //scaffoldBackgroundColor: ColorConstants.scaffoldBackGroundDark.color,
        scaffoldBackgroundColor: Colors.black12,
        appBarTheme:
            AppBarTheme(backgroundColor: ColorConstants.darkBlue.color),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              backgroundColor: ColorConstants.darkBlue.color,
              foregroundColor: Colors.white),
        ),
        cardTheme: CardTheme(color: Color.fromRGBO(41, 38, 57, 1)),
      );

  ThemeData get _lightTheme => ThemeData.light().copyWith(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedIconTheme: IconThemeData(
              color: ColorConstants.customPurple.color, size: 32)),
      cardColor: ColorConstants.timerCardLight.color,
      scaffoldBackgroundColor: ColorConstants.scaffoldBackGround.color,
      appBarTheme:
          AppBarTheme(backgroundColor: ColorConstants.customPurple.color),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
          suffixIconColor: ColorConstants.customPurple.color,
          labelStyle: TextStyle(color: ColorConstants.customPurple.color),
          focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: ColorConstants.customPurple.color))),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            backgroundColor: ColorConstants.customPurple.color,
            foregroundColor: Colors.white),
      ),
      cardTheme: CardTheme(color: Color.fromRGBO(250, 250, 255, 1)));
}
