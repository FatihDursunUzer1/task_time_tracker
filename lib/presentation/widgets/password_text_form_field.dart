import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:task_time_tracker/core/application/constants/validators.dart';
import 'package:task_time_tracker/presentation/generated/locale_keys.g.dart';

class PasswordTextFormField extends StatefulWidget {
  late TextEditingController passwordController;
  late bool isVisible;
  late void Function()? onPressed;
  late String? Function(String? value)? validator;

  PasswordTextFormField(
      {super.key,
      required this.passwordController,
      required this.isVisible,
      this.onPressed,
      this.validator});

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      validator: widget.validator??Validators.validatePassword,
      obscureText: !widget.isVisible,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: LocaleKeys.password.tr(),
        suffixIcon: IconButton(
          icon:
              Icon(!widget.isVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: widget.onPressed,
        ),
      ),
    );
  }
}
