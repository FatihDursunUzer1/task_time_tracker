import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/application/Theme/custom_theme_mode.dart';
import 'package:task_time_tracker/core/application/constants/app_constants.dart';
import 'package:task_time_tracker/core/application/state/global_state_provider.dart';

class FunctionalAppBar extends StatefulWidget implements PreferredSizeWidget {
  String? title;

  FunctionalAppBar({super.key, this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _FunctionalAppBarState createState() => _FunctionalAppBarState();
}

class _FunctionalAppBarState extends State<FunctionalAppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeStateProvider>();
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.all(16.0), //TODO: use constants
          child: GestureDetector(
              child: Icon(theme.themeMode == CustomThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode),
              onTap: () {
                context.read<ThemeStateProvider>().setThemeMode();
              }),
        )
      ],
      title: Text(widget.title ?? AppConstants.appName),
    );
  }
}
