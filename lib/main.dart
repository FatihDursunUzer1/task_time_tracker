import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/application/constants/app_constants.dart';
import 'package:task_time_tracker/core/application/constants/page_constants.dart';
import 'package:task_time_tracker/core/application/navigation/navigation_route.dart';
import 'package:task_time_tracker/core/application/navigation/navigation_service.dart';
import 'package:task_time_tracker/infrastructure/cache/hive_cache_manager.dart';
import 'package:task_time_tracker/infrastructure/repositories/user_repository.dart';
import 'package:task_time_tracker/presentatiton/views/home/home_view_model.dart';
import 'package:task_time_tracker/presentatiton/views/login/login_view_model.dart';
import 'package:task_time_tracker/presentatiton/views/splash/splash_view.dart';
import 'package:task_time_tracker/presentatiton/views/tasks/task_view_model.dart';
import 'package:task_time_tracker/presentatiton/widgets/functional_app_bar.dart';

import 'core/application/state/theme_state_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HiveCacheManager.instance.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ThemeStateProvider()),
    ChangeNotifierProvider(create: (_) => LoginViewModel()),
    ChangeNotifierProvider(create: (_) => HomeViewModel()),
    ChangeNotifierProvider(create: (_) => TaskViewModel())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: context.watch<ThemeStateProvider>().theme,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}

class MainApp extends StatelessWidget {
  int _counter = 0;

  void _incrementCounter() {
    _counter++;
  }

  Future<void> initProject() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeStateProvider>();
    return FutureBuilder(
      builder: (context, snapshot) {
        print(snapshot.connectionState.toString());
        if (snapshot.connectionState == ConnectionState.done) {
          var user = UserRepository.instance.getCurrentUser();
          if(user !=null)
          {
            //context.read<HomeViewModel>().setCurrentUser(user);
            Future.delayed(Duration.zero, () {
              NavigationService.instance.navigateToPageClear(PageConstants.home);
            });
          }
          else
          {
            Future.delayed(Duration.zero, () {
              NavigationService.instance.navigateToPageClear(PageConstants.login);
            });
          }
        }
        return const Splash();
      },
      future: initProject(),
    );
  }
}
