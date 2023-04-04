import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        children: const [
          ListTile(
            leading: FaIcon(FontAwesomeIcons.user),
            title: Text('Profile'),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.trafficLight),
            title: Text('Theme'),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.language),
            title: Text('Language'),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.infoCircle),
            title: Text('About'),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.envelopeOpen),
            title: Text('Connect with us'),
          ),
          ListTile(
            title: Text('Rate Application'),
            leading: FaIcon(FontAwesomeIcons.star),
          ),
          ListTile(
            textColor: Colors.red,
            leading: FaIcon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.red,
            ),
            title: Text('Logout'),
          ),
        ],
      ),
    ));
  }
}
