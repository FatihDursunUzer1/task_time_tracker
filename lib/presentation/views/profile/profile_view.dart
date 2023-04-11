import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/application/constants/validators.dart';
import 'package:task_time_tracker/core/domain/entities/Users/custom_user.dart';
import 'package:task_time_tracker/infrastructure/repositories/user_repository.dart';
import 'package:task_time_tracker/presentation/generated/locale_keys.g.dart';
import 'package:task_time_tracker/presentation/views/home/home_view_model.dart';
import 'package:task_time_tracker/presentation/widgets/custom_button.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late TextEditingController _nameController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _nameController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _nameController.text =
        context.read<HomeViewModel>().currentUser.displayName!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.profile.tr()),
      ),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://www.w3schools.com/howto/img_avatar.png'),
              ),
              TextFormField(
                controller: _nameController,
                validator: Validators.checkEmptyText,
                decoration: InputDecoration(
                    labelText: LocaleKeys.name.tr(),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red))),
                readOnly: false,
                enabled: true,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                enabled: false,
                decoration: InputDecoration(
                    labelText: LocaleKeys.email.tr(),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red))),
                readOnly: true,
                initialValue: context.read<HomeViewModel>().currentUser.email,
              ),
              CustomButton(
                  text: LocaleKeys.update.tr(),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //context.read<HomeViewModel>().updateProfile(_nameController.text);
                      /* context.read<HomeViewModel>().setCurrentUser(
                          context.read<HomeViewModel>().currentUser.copyWith(
                              displayName: _nameController.text,
                             )); */
                      context.read<HomeViewModel>().setCurrentUser(CustomUser(
                          id: context.read<HomeViewModel>().currentUser.id,
                          displayName: _nameController.text,
                          email:
                              context.read<HomeViewModel>().currentUser.email,
                          emailVerified: context
                              .read<HomeViewModel>()
                              .currentUser
                              .emailVerified,
                          photoURL: context
                              .read<HomeViewModel>()
                              .currentUser
                              .photoURL));

                      UserRepository.instance.updateUser(
                          context.read<HomeViewModel>().currentUser);
                    }
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
