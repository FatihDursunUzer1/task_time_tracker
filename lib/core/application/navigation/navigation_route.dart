import 'package:flutter/material.dart';
import 'package:task_time_tracker/core/application/constants/page_constants.dart';
import 'package:task_time_tracker/presentatiton/views/home/home_view.dart';
import 'package:task_time_tracker/presentatiton/views/login/login_view.dart';
import 'package:task_time_tracker/presentatiton/views/register/register_view.dart';
import 'package:task_time_tracker/presentatiton/views/tasks/task_view.dart';

import '../../../main.dart';
import '../../../presentatiton/views/splash/splash_view.dart';

class NavigationRoute {
  static NavigationRoute? _instance;
  static NavigationRoute get instance {
    _instance ??= NavigationRoute._();
    return _instance!;
  }

  NavigationRoute._();
  defaultRoute(Widget page) {
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
      default:
        return defaultRoute(Home());
    }
  }
}
