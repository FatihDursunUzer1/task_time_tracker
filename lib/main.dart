import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/application/constants/app_constants.dart';
import 'package:task_time_tracker/core/application/constants/page_constants.dart';
import 'package:task_time_tracker/core/application/languages/language_manager.dart';
import 'package:task_time_tracker/core/application/navigation/navigation_route.dart';
import 'package:task_time_tracker/core/application/navigation/navigation_service.dart';
import 'package:task_time_tracker/core/application/state/version_checker_provider.dart';
import 'package:task_time_tracker/core/domain/entities/Users/custom_user.dart';
import 'package:task_time_tracker/firebase_options.dart';
import 'package:task_time_tracker/infrastructure/cache/hive_cache_manager.dart';
import 'package:task_time_tracker/infrastructure/repositories/user_repository.dart';
import 'package:task_time_tracker/presentation/views/add/add_task_view_model.dart';
import 'package:task_time_tracker/presentation/views/home/home_view_model.dart';
import 'package:task_time_tracker/presentation/views/login/login_view_model.dart';
import 'package:task_time_tracker/presentation/views/register/register_view_model.dart';
import 'package:task_time_tracker/presentation/views/splash/splash_view.dart';
import 'package:task_time_tracker/presentation/views/tasks/task_view_model.dart';
import 'package:task_time_tracker/presentation/widgets/functional_app_bar.dart';

import 'core/application/state/theme_state_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await HiveCacheManager.instance.init();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  VersionChecker.instance.checkVersion(packageInfo.version);
  runApp(EasyLocalization(
    supportedLocales: LanguageManager.instance.supportedLocales,
    path: 'assets/translations',
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeStateProvider()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => TaskViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => AddTaskViewModel())
      ],
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
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

  Future<CustomUser?> initProject() async {
    await Future.delayed(const Duration(seconds: 2));
    var user = await UserRepository.instance.getCurrentUser();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeStateProvider>();
    return FutureBuilder(
      builder: (context, snapshot) {
        print(snapshot.connectionState.toString());
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            context
                .read<HomeViewModel>()
                .setCurrentUser(snapshot.data as CustomUser);
            Future.delayed(Duration.zero, () {
              NavigationService.instance
                  .navigateToPageClear(PageConstants.home);
            });
          } else {
            Future.delayed(Duration.zero, () {
              NavigationService.instance
                  .navigateToPageClear(PageConstants.login);
            });
          }
        }
        return const Splash();
      },
      future: initProject(),
    );
  }
}
