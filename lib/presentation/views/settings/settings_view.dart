import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_time_tracker/presentation/generated/locale_keys.g.dart';

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
          ListTile(
            leading: FaIcon(FontAwesomeIcons.user),
            title: Text(LocaleKeys.profile.tr()),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.trafficLight),
            title: Text(LocaleKeys.theme.tr()),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.language),
            title: Text(LocaleKeys.languages.tr()),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.infoCircle),
            title: Text(LocaleKeys.about.tr()),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.envelopeOpen),
            title: Text(LocaleKeys.contact_us.tr()),
          ),
          ListTile(
            title: Text(LocaleKeys.rate_application.tr()),
            leading: FaIcon(FontAwesomeIcons.star),
          ),
          ListTile(
            textColor: Colors.red,
            leading: FaIcon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.red,
            ),
            title: Text(LocaleKeys.logout.tr()),
          ),
        ],
      ),
    ));
  }
}
