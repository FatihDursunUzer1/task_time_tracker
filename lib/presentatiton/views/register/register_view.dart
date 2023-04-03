import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/application/constants/page_constants.dart';
import 'package:task_time_tracker/core/application/constants/validators.dart';
import 'package:task_time_tracker/core/application/navigation/navigation_service.dart';
import 'package:task_time_tracker/presentatiton/views/home/home_view_model.dart';
import 'package:task_time_tracker/presentatiton/views/register/register_view_model.dart';
import 'package:task_time_tracker/presentatiton/widgets/custom_button.dart';

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
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icon/ic_logo.png'),
                Form(
                    key: context.read<RegisterViewModel>().formKey,
                    child: Column(children: [
                      TextFormField(
                        controller:
                            context.read<RegisterViewModel>().emailController,
                        validator: Validators.validateEmail,
                      ),
                      TextFormField(
                          controller: context
                              .read<RegisterViewModel>()
                              .passwordController,
                          validator: Validators.validatePassword),
                      TextFormField(
                          controller: context
                              .read<RegisterViewModel>()
                              .passwordAgainController,
                          validator: context
                              .read<RegisterViewModel>()
                              .validatePasswordAgain),
                      CustomButton(
                        onPressed: () async {
                          var customUser = await context
                              .read<RegisterViewModel>()
                              .registerWithEmailAndPassword();

                          if (customUser != null) {
                            context
                                .read<HomeViewModel>()
                                .setCurrentUser(customUser);
                            NavigationService.instance
                                .navigateToPageClear(PageConstants.home);
                          }
                        },
                        text: 'Register',
                      ),
                    ])),
              ],
            ),
          ),
        ));
  }
}
