import 'package:flutter/material.dart';
import 'package:task_time_tracker/core/application/constants/page_constants.dart';
import 'package:task_time_tracker/core/application/navigation/navigation_service.dart';
import 'package:task_time_tracker/core/domain/entities/Users/IUserRepository.dart';
import 'package:task_time_tracker/core/domain/entities/Users/custom_user.dart';
import 'package:task_time_tracker/infrastructure/repositories/user_repository.dart';
import 'package:task_time_tracker/presentatiton/utility/enums/OAuthMethods.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final UserRepository _userRepository =
      UserRepository.instance; //TO DO: This must be interface, but not now

  bool get isVisible => _isVisible;
  void setIsVisible() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  

  validate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      return true;
      /*_clearAll();
      NavigationService.instance.navigateToPageClear(PageConstants.home); */
    } else {
      return false;
    }
  }

  goToRegister() {
    _clearAll();
    NavigationService.instance.navigateToPage(path: PageConstants.register);
  }

  goToHomePage() {
    _clearAll();
    NavigationService.instance.navigateToPageClear(PageConstants.home);
  }

  signInWithOAuths(OAuthMethods oAuthMethod) {}

  signInWithEmailAndPassword() async {
    var customUser = await _userRepository.signInWithEmailAndPassword(
        emailController.text, passwordController.text);
    if (customUser == null) return null;
    return customUser;
  }

  _clearAll() {
    emailController.text = '';
    passwordController.text = '';
    debugPrint(emailController.text);
    notifyListeners();
  }
}
