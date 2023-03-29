import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/application/constants/page_constants.dart';
import 'package:task_time_tracker/core/application/navigation/navigation_service.dart';
import 'package:task_time_tracker/presentatiton/views/login/login_view_model.dart';

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
                      TextFormField(
                        controller:
                            context.read<LoginViewModel>().emailController,
                        validator: context.read<LoginViewModel>().validateEmail,
                        decoration: InputDecoration(labelText: 'Login'),
                      ),
                      PasswordTextFormField(context),
                      LoginButton(context),
                      const Divider(),
                      Text('Or'),
                      const Divider(),
                      LoginWithGoogle(context),
                    ]),
              )),
        ));
  }

  Container LoginWithGoogle(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(onPressed: () {}, child: Text('Login with Google')),
    );
  }

  Container LoginButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
          onPressed: () {
            if (context
                .read<LoginViewModel>()
                .formKey
                .currentState!
                .validate()) {
              print('Validated');
              NavigationService.instance
                  .navigateToPage(path: PageConstants.home);
            }
          },
          child: Text('Login')),
    );
  }

  TextFormField PasswordTextFormField(BuildContext context) {
    return TextFormField(
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
