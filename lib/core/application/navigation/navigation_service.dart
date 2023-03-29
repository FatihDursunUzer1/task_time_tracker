import 'package:flutter/material.dart';
import 'package:task_time_tracker/core/application/navigation/INavigationService.dart';

class NavigationService implements INavigationService {
  static NavigationService? _instance;
  static NavigationService get instance {
    _instance ??= NavigationService._();
    return _instance!;
  }

  NavigationService._();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  navigateToPageClear(String routeName) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }

  @override
  Future<void> navigateToPage({String? path, Object? data}) async {
    await navigatorKey.currentState!.pushNamed(path!, arguments: data);
  }
}
