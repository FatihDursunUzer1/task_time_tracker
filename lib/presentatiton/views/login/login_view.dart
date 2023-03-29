import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Login'),
                    ),
                    PasswordTextFormField(context),
                    OutlinedButton.icon(
                        onPressed: () {
                          NavigationService.instance
                              .navigateToPage(path: PageConstants.home);
                        },
                        icon: Icon(Icons.login_outlined),
                        label: Text('Login')),
                    const Divider()
                  ])),
        ));
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
