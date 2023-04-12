import 'package:flutter/material.dart';
import 'package:task_time_tracker/presentation/views/settings/general_policy.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return const GeneralPolicy(
        url:
            'https://docs.google.com/document/d/1NIPi_yk9JaMSDJ9Be7Yoy_wGguILi0ctHFeHeUZ6a3g/edit?usp=sharing');
  }
}
