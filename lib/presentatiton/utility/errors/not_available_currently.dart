import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotAvailable extends StatefulWidget {
  const NotAvailable({super.key});

  @override
  State<NotAvailable> createState() => _NotAvailableState();
}

class _NotAvailableState extends State<NotAvailable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              children: const [
                Text(
                  'Not Available For This Version.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('We will add this feature in the next version',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
