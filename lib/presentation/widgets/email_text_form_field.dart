import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:task_time_tracker/core/application/constants/validators.dart';
import 'package:task_time_tracker/presentation/generated/locale_keys.g.dart';

class EmailTextFormField extends StatelessWidget {
  final TextEditingController controller;
  const EmailTextFormField({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: Validators.validateEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: LocaleKeys.email.tr(),
      ),
    );
  }
}