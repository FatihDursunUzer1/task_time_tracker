import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_time_tracker/presentation/generated/locale_keys.g.dart';

class NotAvailable extends StatefulWidget {
  const NotAvailable({super.key});

  @override
  State<NotAvailable> createState() => _NotAvailableState();
}

class _NotAvailableState extends State<NotAvailable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Container(
      color: Colors.red[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FaIcon(
            FontAwesomeIcons.exclamationTriangle,
            size: 100,
            color: Colors.yellow,
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              children: [
                Text(
                  LocaleKeys.not_available_current_version.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
