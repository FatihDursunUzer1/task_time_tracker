import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/application/Theme/custom_theme_mode.dart';
import 'package:task_time_tracker/core/application/state/theme_state_provider.dart';
import 'package:task_time_tracker/presentation/generated/locale_keys.g.dart';
import 'package:task_time_tracker/presentation/widgets/functional_app_bar.dart';

class SetTheme extends StatefulWidget {
  const SetTheme({super.key});

  @override
  State<SetTheme> createState() => _SetThemeState();
}

class _SetThemeState extends State<SetTheme> {
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeStateProvider>();
    return Scaffold(
      appBar: FunctionalAppBar(),
      body: SizedBox(
          child: SwitchListTile(
        title: Text(LocaleKeys.dark_theme.tr()),
        value: theme.themeMode == CustomThemeMode.dark,
        onChanged: (value) {
          context.read<ThemeStateProvider>().setThemeMode();
        },
      )),
    );
  }
}
