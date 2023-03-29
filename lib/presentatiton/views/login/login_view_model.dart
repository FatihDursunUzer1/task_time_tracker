import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isVisible = false;

  bool get isVisible => _isVisible;
  void setIsVisible() {
    _isVisible = !_isVisible;
    notifyListeners();
  }
}
