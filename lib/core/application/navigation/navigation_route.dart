import 'package:flutter/material.dart';
import 'package:task_time_tracker/core/application/constants/page_constants.dart';
import 'package:task_time_tracker/presentatiton/views/home/home_view.dart';

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
      default:
        return defaultRoute(Home());
    }
  }
}
