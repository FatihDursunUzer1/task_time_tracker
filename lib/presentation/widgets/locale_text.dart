import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LocaleText extends StatelessWidget {
  final String data;
  const LocaleText({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(data.tr());
  }
}
