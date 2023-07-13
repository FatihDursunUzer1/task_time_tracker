import 'package:flutter/material.dart';
import 'package:task_time_tracker/core/application/constants/page_constants.dart';
import 'package:task_time_tracker/presentation/utility/errors/not_available_currently.dart';
import 'package:task_time_tracker/presentation/views/home/home_view.dart';
import 'package:task_time_tracker/presentation/views/login/login_view.dart';
import 'package:task_time_tracker/presentation/views/profile/profile_view.dart';
import 'package:task_time_tracker/presentation/views/register/register_view.dart';
import 'package:task_time_tracker/presentation/views/settings/about/about_view.dart';
import 'package:task_time_tracker/presentation/views/settings/contact/contact_us_view.dart';
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
        return defaultRoute(const Splash());
      case PageConstants.home:
        return defaultRoute(const Home());
      case PageConstants.login:
        return defaultRoute(const Login());
      case PageConstants.register:
        return defaultRoute(const Register());
      case PageConstants.task:
        return defaultRoute(const TaskView());
      case PageConstants.languages:
        return defaultRoute(const SetLanguage());
      case PageConstants.theme:
        return defaultRoute(const SetTheme());
      case PageConstants.privacyPolicy:
        return defaultRoute(const PrivacyPolicy());
      case PageConstants.termsOfService:
        return defaultRoute(const TermsAndConditions());
      case PageConstants.profile:
        return defaultRoute(const Profile());
      case PageConstants.about:
        return defaultRoute(const About());
      case PageConstants.contactUs:
        return defaultRoute(const EmailSender());
      default:
        return defaultRoute(const NotAvailable());
    }
  }
}
