import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool get isVisible => _isVisible;
  void setIsVisible() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    if (emailController.text.isEmpty) {
      return 'Email is required';
    } else if (!emailController.text.contains('@')) {
      return 'Email is invalid';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (passwordController.text.isEmpty) {
      return 'Password is required';
    } else if (passwordController.text.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
