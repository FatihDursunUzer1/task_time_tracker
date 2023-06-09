import 'package:flutter/material.dart';
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
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.black,
            selectedIconTheme:
                IconThemeData(color: ColorConstants.customPurple, size: 32)),
        inputDecorationTheme: const InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(vertical: 0.0),
            suffixIconColor: ColorConstants.darkBlue,
            labelStyle: TextStyle(color: ColorConstants.darkBlue),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.customPurple))),
        cardColor: ColorConstants.timerCardDark,
        //scaffoldBackgroundColor: ColorConstants.scaffoldBackGroundDark,
        scaffoldBackgroundColor: Colors.black12,
        appBarTheme: const AppBarTheme(backgroundColor: ColorConstants.darkBlue),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              backgroundColor: ColorConstants.darkBlue,
              foregroundColor: Colors.white),
        ),
        cardTheme: const CardTheme(color: Color.fromRGBO(41, 38, 57, 1)),
        listTileTheme: const ListTileThemeData(textColor: Colors.white),
      );

  ThemeData get _lightTheme => ThemeData.light().copyWith(
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedIconTheme:
              IconThemeData(color: ColorConstants.customPurple, size: 32)),
      cardColor: ColorConstants.timerCardLight,
      scaffoldBackgroundColor: ColorConstants.scaffoldBackGround,
      appBarTheme: const AppBarTheme(backgroundColor: ColorConstants.customPurple),
      inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(vertical: 0.0),
          suffixIconColor: ColorConstants.customPurple,
          labelStyle: TextStyle(color: ColorConstants.customPurple),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.customPurple))),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            backgroundColor: ColorConstants.customPurple,
            foregroundColor: Colors.white),
      ),
      cardTheme: const CardTheme(color: Color.fromRGBO(250, 250, 255, 1)),
      listTileTheme: const ListTileThemeData(textColor: Colors.black));
}
