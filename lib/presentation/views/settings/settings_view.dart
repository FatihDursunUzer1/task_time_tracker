import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/application/constants/page_constants.dart';
import 'package:task_time_tracker/core/application/navigation/navigation_service.dart';
import 'package:task_time_tracker/infrastructure/repositories/user_repository.dart';
import 'package:task_time_tracker/presentation/generated/locale_keys.g.dart';
import 'package:task_time_tracker/presentation/widgets/functional_app_bar.dart';

import '../home/home_view_model.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          customListTile(
              icon: const Icon(FontAwesomeIcons.user),
              text: LocaleKeys.profile.tr(),
              onTap: () {
                NavigationService.instance
                    .navigateToPage(path: PageConstants.profile);
              }),
          customListTile(
              icon: const Icon(FontAwesomeIcons.language),
              text: LocaleKeys.languages.tr(),
              onTap: () {
                NavigationService.instance
                    .navigateToPage(path: PageConstants.languages);
              }),
          customListTile(
              icon: const Icon(FontAwesomeIcons.sun),
              text: LocaleKeys.theme.tr(),
              onTap: () {
                NavigationService.instance
                    .navigateToPage(path: PageConstants.theme);
              }),
          customListTile(
              icon: const Icon(FontAwesomeIcons.envelope),
              text: LocaleKeys.contact_us.tr(),
              onTap: () {}),
          customListTile(
              icon: const Icon(FontAwesomeIcons.infoCircle),
              text: LocaleKeys.about.tr(),
              onTap: () {}),
          customListTile(
              icon: const FaIcon(FontAwesomeIcons.userSecret),
              //text: LocaleKeys.privacy_policy.tr(),
              text: LocaleKeys.privacy_policy.tr(),
              onTap: () {}),
          customListTile(
              icon: const FaIcon(FontAwesomeIcons.fileContract),
              text: LocaleKeys.terms_of_use.tr(),
              onTap: () {}),
          customListTile(
              icon: const FaIcon(FontAwesomeIcons.question),
              text: LocaleKeys.help.tr(),
              onTap: () {}),
          customListTile(
              textColor: Colors.red,
              icon: const Icon(
                FontAwesomeIcons.signOutAlt,
                color: Colors.red,
              ),
              text: LocaleKeys.logout.tr(),
              onTap: () {
                return showDialog(
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
                                  context
                                      .read<HomeViewModel>()
                                      .setCurrentNavBarIndex(0);
                                  NavigationService.instance
                                      .navigateToPageClear(PageConstants.login);
                                },
                                child: Text(LocaleKeys.yes.tr())),
                          ],
                        ));
                /* NavigationService.instance
                .navigateToPageClear(PageConstants.login); */
              }),
          customListTile(
              textColor: Colors.red,
              icon: const Icon(
                FontAwesomeIcons.trash,
                color: Colors.red,
              ),
              text: LocaleKeys.delete_account.tr(),
              onTap: () {
                return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text(LocaleKeys.delete_account_message.tr()),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(LocaleKeys.no.tr())),
                            TextButton(
                                onPressed: () {
                                  UserRepository.instance.deleteAccount();
                                  context
                                      .read<HomeViewModel>()
                                      .setCurrentNavBarIndex(0);
                                  NavigationService.instance
                                      .navigateToPageClear(PageConstants.login);
                                },
                                child: Text(LocaleKeys.yes.tr())),
                          ],
                        ));
              }),
        ],
      ),
    ));
  }

  customListTile(
      {required Widget icon,
      required String text,
      required Function onTap,
      Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
      child: ListTile(
        textColor: textColor ?? Colors.black,
        onTap: () {
          onTap();
        },
        leading: icon,
        title: Text(text),
      ),
    );
  }
}
