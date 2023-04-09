import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/application/constants/page_constants.dart';
import 'package:task_time_tracker/core/application/constants/validators.dart';
import 'package:task_time_tracker/core/application/navigation/navigation_service.dart';
import 'package:task_time_tracker/presentation/views/home/home_view_model.dart';
import 'package:task_time_tracker/presentation/views/register/register_view_model.dart';
import 'package:task_time_tracker/presentation/widgets/custom_button.dart';
import 'package:task_time_tracker/presentation/widgets/email_text_form_field.dart';
import 'package:task_time_tracker/presentation/widgets/password_text_form_field.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icon/ic_logo.png'),
                  Form(
                      key: context.read<RegisterViewModel>().formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextFormField(
                              controller: context
                                  .read<RegisterViewModel>()
                                  .nameController,
                              validator: Validators.checkEmptyText,
                              decoration: const InputDecoration(
                                hintText: 'Name',
                              ),
                            ),
                            EmailTextFormField(
                              controller: context
                                  .read<RegisterViewModel>()
                                  .emailController,
                            ),
                            PasswordTextFormField(
                              passwordController: context
                                  .read<RegisterViewModel>()
                                  .passwordController,
                              isVisible:
                                  context.watch<RegisterViewModel>().isVisible,
                              onPressed: () {
                                context
                                    .read<RegisterViewModel>()
                                    .setIsVisible();
                              },
                            ),
                            PasswordTextFormField(
                              passwordController: context
                                  .read<RegisterViewModel>()
                                  .passwordAgainController,
                              isVisible:
                                  context.watch<RegisterViewModel>().isVisible,
                              onPressed: () {
                                context
                                    .read<RegisterViewModel>()
                                    .setIsVisible();
                              },
                              validator: context
                                  .read<RegisterViewModel>()
                                  .validatePasswordAgain,
                            ),
                            CustomButton(
                              onPressed: () async {
                                var validate = context
                                    .read<RegisterViewModel>()
                                    .validate();
                                if (validate) {
                                  var customUser = await context
                                      .read<RegisterViewModel>()
                                      .registerWithEmailAndPassword();
                                  if (customUser != null) {
                                    context
                                        .read<RegisterViewModel>()
                                        .goToLogin();
                                  }
                                }
                              },
                              text: 'Register',
                            ),
                          ])),
                ],
              ),
            ),
          ),
        ));
  }
}
