import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:task_time_tracker/presentation/views/settings/general_policy.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return const GeneralPolicy(
        url:
            'https://docs.google.com/document/d/1FnrbDgoR4vW9h9C1v2S6HeIkGZNtZDYGwhA-X1VEiAQ/edit?usp=sharing');
  }
}
