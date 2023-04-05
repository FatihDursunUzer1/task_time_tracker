import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/application/Theme/custom_theme_mode.dart';
import 'package:task_time_tracker/core/application/constants/app_constants.dart';
import 'package:task_time_tracker/core/application/constants/page_constants.dart';
import 'package:task_time_tracker/core/application/navigation/navigation_service.dart';
import 'package:task_time_tracker/core/application/state/theme_state_provider.dart';
import 'package:task_time_tracker/infrastructure/repositories/user_repository.dart';
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
        ),
        ExitButton(context),
      ],
      title: Text(widget.title ?? LocaleKeys.app_name.tr()),
    );
  }

  IconButton ExitButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(LocaleKeys.logout_message.tr()),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(LocaleKeys.no.tr())),
                      TextButton(
                          onPressed: () {
                            UserRepository.instance.signOut();
                            NavigationService.instance
                                .navigateToPageClear(PageConstants.login);
                          },
                          child: Text(LocaleKeys.yes.tr())),
                    ],
                  ));
          /* NavigationService.instance
                .navigateToPageClear(PageConstants.login); */
        },
        icon: const FaIcon(FontAwesomeIcons.signOutAlt));
  }
}
