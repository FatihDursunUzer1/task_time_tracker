import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/application/constants/app_constants.dart';
import 'package:task_time_tracker/core/application/constants/page_constants.dart';
import 'package:task_time_tracker/infrastructure/cache/hive_cache_manager.dart';
import 'package:task_time_tracker/presentatiton/widgets/functional_app_bar.dart';

import 'core/application/state/global_state_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveCacheManager.instance.init();
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeStateProvider())],
      child: const MyApp()));
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
      initialRoute: PageConstants.home,
      routes: {
        PageConstants.home: (context) => Home(),
      },
    );
  }
}

class Home extends StatelessWidget {
  int _counter = 0;

  void _incrementCounter() {
    _counter++;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeStateProvider>();
    return Scaffold(
      appBar: FunctionalAppBar(
        title: PageConstants.home,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
