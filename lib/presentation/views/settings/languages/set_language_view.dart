import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_time_tracker/core/application/constants/page_constants.dart';
import 'package:task_time_tracker/core/application/languages/language_manager.dart';
import 'package:task_time_tracker/core/application/navigation/navigation_service.dart';
import 'package:task_time_tracker/presentation/widgets/functional_app_bar.dart';

import '../../../generated/locale_keys.g.dart';

class SetLanguage extends StatefulWidget {
  const SetLanguage({super.key});

  @override
  State<SetLanguage> createState() => _SetLanguageState();
}

class _SetLanguageState extends State<SetLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FunctionalAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          languageInkWell(context, LanguageManager.instance.trLocale, "Türkçe"),
          languageInkWell(
              context, LanguageManager.instance.enLocale, "English"),
        ],
      ),
    );
  }

  languageInkWell(BuildContext context, Locale locale, String language) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() async {
              if (context.locale != locale) {
                await context.setLocale(locale);
              }
              NavigationService.instance
                  .navigateToPageClear(PageConstants.home);
            });
          },
          child: ListTile(title: Text(language)),
        ),
        const Divider()
      ],
    );
  }
}
