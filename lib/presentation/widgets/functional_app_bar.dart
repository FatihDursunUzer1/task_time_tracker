import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/application/state/theme_state_provider.dart';
import 'package:task_time_tracker/presentation/generated/locale_keys.g.dart';

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
      centerTitle: true,
      title: Text(widget.title ?? LocaleKeys.app_name.tr()),
    );
  }
}
