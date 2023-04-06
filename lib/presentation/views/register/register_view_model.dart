import 'package:flutter/material.dart';
import 'package:task_time_tracker/core/application/constants/page_constants.dart';
import 'package:task_time_tracker/core/application/navigation/navigation_service.dart';
import 'package:task_time_tracker/infrastructure/repositories/user_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordAgainController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserRepository _userRepository = UserRepository.instance;
  bool _isVisible = false;
  bool get isVisible => _isVisible;
  void setIsVisible() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  validate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      return true;
    } else {
      return false;
    }
  }

  _clearAll() {
    emailController.text = '';
    passwordController.text = '';
    passwordAgainController.text = '';
    notifyListeners();
  }

  goToLogin() {
    _clearAll();
    NavigationService.instance.navigateToPageClear(PageConstants.login);
  }

  goToHome() {
    _clearAll();
    NavigationService.instance.navigateToPageClear(PageConstants.home);
  }

  registerWithEmailAndPassword() async {
    var customUser = await _userRepository.registerWithEmailAndPassword(
        emailController.text, passwordController.text);
    if (customUser == null) return null;
    return customUser;
  }

  String? validatePasswordAgain(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
  }
}
