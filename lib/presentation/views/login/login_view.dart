import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/application/constants/color_constants.dart';
import 'package:task_time_tracker/presentation/generated/locale_keys.g.dart';
import 'package:task_time_tracker/presentation/utility/enums/OAuthMethods.dart';
import 'package:task_time_tracker/presentation/views/home/home_view_model.dart';
import 'package:task_time_tracker/presentation/views/login/login_view_model.dart';
import 'package:task_time_tracker/presentation/widgets/custom_button.dart';
import 'package:task_time_tracker/presentation/widgets/email_text_form_field.dart';
import 'package:task_time_tracker/presentation/widgets/password_text_form_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: context.read<LoginViewModel>().formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icon/ic_logo.png',
                      ),
                      EmailTextFormField(
                        controller:
                            context.read<LoginViewModel>().emailController,
                      ),
                      PasswordTextFormField(
                        passwordController:
                            context.read<LoginViewModel>().passwordController,
                        isVisible: context.watch<LoginViewModel>().isVisible,
                        onPressed: () {
                          context.read<LoginViewModel>().setIsVisible();
                        },
                      ),
                      LoginButton(context),
                      /*Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SignInMethods(context, FontAwesomeIcons.google,
                              onPressed: context
                                  .read<LoginViewModel>()
                                  .signInWithOAuths(OAuthMethods.google)),
                          SignInMethods(context, FontAwesomeIcons.facebook,
                              onPressed: context
                                  .read<LoginViewModel>()
                                  .signInWithOAuths(OAuthMethods.facebook)),
                          SignInMethods(context, FontAwesomeIcons.twitter,
                              onPressed: context
                                  .read<LoginViewModel>()
                                  .signInWithOAuths(OAuthMethods.twitter)),
                          SignInMethods(context, FontAwesomeIcons.apple,
                              onPressed: context
                                  .read<LoginViewModel>()
                                  .signInWithOAuths(OAuthMethods.apple)),
                        ], 
                      ), */
                      const Divider(),
                      Text(LocaleKeys.or.tr()),
                      const Divider(),
                      RegisterButton(context),
                    ]),
              )),
        ),
      ),
    );
  }

  IconButton SignInMethods(BuildContext context, IconData icon,
      {Function()? onPressed}) {
    return IconButton(
        onPressed: onPressed ?? () {},
        icon: FaIcon(
          icon,
          color: ColorConstants.customPurple,
        ));
  }

  RegisterButton(BuildContext context) {
    return CustomButton(
        onPressed: () {
          context.read<LoginViewModel>().goToRegister();
        },
        text: LocaleKeys.register.tr());
  }

  LoginButton(BuildContext context) {
    return CustomButton(
        text: LocaleKeys.login.tr(),
        onPressed: () async {
          var validate = context.read<LoginViewModel>().validate();
          if (validate) {
            var customUser = await context
                .read<LoginViewModel>()
                .signInWithEmailAndPassword();
            if (customUser != null) {
              context.read<HomeViewModel>().setCurrentUser(customUser);
              context.read<LoginViewModel>().goToHomePage();
            }
          }
        });
  }
}
