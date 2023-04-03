import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/application/constants/color_constants.dart';
import 'package:task_time_tracker/core/application/constants/page_constants.dart';
import 'package:task_time_tracker/core/application/navigation/navigation_service.dart';
import 'package:task_time_tracker/presentatiton/utility/enums/OAuthMethods.dart';
import 'package:task_time_tracker/presentatiton/views/home/home_view_model.dart';
import 'package:task_time_tracker/presentatiton/views/login/login_view_model.dart';
import 'package:task_time_tracker/presentatiton/widgets/custom_button.dart';

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
                      EmailTextFormField(context),
                      PasswordTextFormField(context),
                      LoginButton(context),
                      Row(
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
                      ),
                      const Divider(),
                      Text('Or'),
                      const Divider(),
                      RegisterButton(context),
                    ]),
              )),
        ));
  }

  IconButton SignInMethods(BuildContext context, IconData icon,
      {Function()? onPressed}) {
    return IconButton(
        onPressed: onPressed == null ? () {} : onPressed,
        icon: FaIcon(
          icon,
          color: ColorConstants.customPurple.color,
        ));
  }

  RegisterButton(BuildContext context) {
    return CustomButton(
        onPressed: () {
          context.read<LoginViewModel>().goToRegister();
        },
        text: 'Register');
  }

  LoginButton(BuildContext context) {
    return CustomButton(
        text: 'Login',
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

  TextFormField EmailTextFormField(BuildContext context) {
    return TextFormField(
      controller: context.read<LoginViewModel>().emailController,
      validator: context.read<LoginViewModel>().validateEmail,
      decoration: InputDecoration(labelText: 'Email'),
    );
  }

  TextFormField PasswordTextFormField(BuildContext context) {
    return TextFormField(
      controller: context.read<LoginViewModel>().passwordController,
      validator: context.read<LoginViewModel>().validatePassword,
      obscureText: !context.watch<LoginViewModel>().isVisible,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(!context.watch<LoginViewModel>().isVisible
              ? Icons.visibility
              : Icons.visibility_off),
          onPressed: () {
            context.read<LoginViewModel>().setIsVisible();
          },
        ),
      ),
    );
  }
}
