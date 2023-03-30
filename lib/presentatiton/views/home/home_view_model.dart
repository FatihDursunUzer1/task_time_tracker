import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  int _currentNavBarIndex = 0;
  int get currentNavBarIndex => _currentNavBarIndex;
  void setCurrentNavBarIndex(int index) {
    _currentNavBarIndex = index;
    notifyListeners();
  }
}
