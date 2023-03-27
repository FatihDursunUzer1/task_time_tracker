import 'package:flutter/material.dart';
import 'package:task_time_tracker/core/application/Theme/theme_manager.dart';

class ThemeStateProvider extends ChangeNotifier {
  ThemeManager instance = ThemeManager.instance;

  void setTheme() {
    instance.setThemeMode();
    notifyListeners();
  }
}
