import 'package:flutter/material.dart';
import 'package:task_time_tracker/core/application/constants/page_constants.dart';
import 'package:task_time_tracker/presentation/utility/errors/not_available_currently.dart';
import 'package:task_time_tracker/presentation/views/home/home_view.dart';
import 'package:task_time_tracker/presentation/views/login/login_view.dart';
import 'package:task_time_tracker/presentation/views/profile/profile_view.dart';
import 'package:task_time_tracker/presentation/views/register/register_view.dart';
import 'package:task_time_tracker/presentation/views/settings/languages/set_language_view.dart';
import 'package:task_time_tracker/presentation/views/settings/privacy/privacy_policy.dart';
import 'package:task_time_tracker/presentation/views/settings/terms/terms_and_conditions.dart';
import 'package:task_time_tracker/presentation/views/settings/theme/set_theme_view.dart';
import 'package:task_time_tracker/presentation/views/tasks/task_view.dart';

import '../../../main.dart';
import '../../../presentation/views/splash/splash_view.dart';

class NavigationRoute {
  static NavigationRoute? _instance;
  static NavigationRoute get instance {
    _instance ??= NavigationRoute._();
    return _instance!;
  }

  NavigationRoute._();
  defaultRoute(page) {
    return MaterialPageRoute(
      builder: (context) => page,
    );
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageConstants.main:
        return defaultRoute(MainApp());
      case PageConstants.splash:
        return defaultRoute(Splash());
      case PageConstants.home:
        return defaultRoute(Home());
      case PageConstants.login:
        return defaultRoute(Login());
      case PageConstants.register:
        return defaultRoute(Register());
      case PageConstants.task:
        return defaultRoute(TaskView());
      case PageConstants.languages:
        return defaultRoute(SetLanguage());
      case PageConstants.theme:
        return defaultRoute(SetTheme());
      case PageConstants.privacyPolicy:
        return defaultRoute(PrivacyPolicy());
      case PageConstants.termsOfService:
        return defaultRoute(TermsAndConditions());
      case PageConstants.profile:
        return defaultRoute(Profile());
      default:
        return defaultRoute(NotAvailable());
    }
  }
}
