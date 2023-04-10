import 'package:flutter/material.dart';
import 'package:task_time_tracker/presentation/views/settings/general_policy.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return const GeneralPolicy(
        url:
            'https://docs.google.com/document/d/1fD8ksAQhh7kJHos-06s-rIBsS5Kf3-1CDdfEZWcvbxA/edit?usp=sharing');
  }
}
