import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/application/constants/color_constants.dart';
import 'package:task_time_tracker/core/application/constants/validators.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task_tags.dart';
import 'package:task_time_tracker/infrastructure/repositories/task_repository.dart';
import 'package:task_time_tracker/infrastructure/repositories/user_repository.dart';
import 'package:task_time_tracker/presentation/generated/locale_keys.g.dart';
import 'package:task_time_tracker/presentation/views/add/add_task_view_model.dart';
import 'package:task_time_tracker/presentation/views/home/home_view_model.dart';
import 'package:task_time_tracker/presentation/widgets/custom_button.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: context.read<AddTaskViewModel>().formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.add_task.tr(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              TextFormField(
                validator: Validators.checkEmptyText,
                controller:
                    context.read<AddTaskViewModel>().titleEditingController,
                decoration: InputDecoration(
                  hintText: LocaleKeys.title.tr(),
                ),
              ),
              Divider(),
              TextFormField(
                validator: Validators.checkEmptyText,
                controller: context
                    .read<AddTaskViewModel>()
                    .descriptionEditingController,
                decoration: InputDecoration(
                  hintText: LocaleKeys.task_description.tr(),
                ),
                maxLines: 5,
              ),
              TaskTagDropdownButton(context),
              CustomButton(
                  onPressed: () {
                    var currentState =
                        context.read<AddTaskViewModel>().formKey.currentState!;
                    if (currentState.validate()) {
                      currentState.save();
                      context.read<AddTaskViewModel>().addTask();
                      context.read<HomeViewModel>().setCurrentNavBarIndex(0);
                    }
                  },
                  text: LocaleKeys.add_task.tr()),
            ],
          ),
        ),
      ),
    );
  }

  TaskTagDropdownButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('${LocaleKeys.task_tags.tr()}: ', style: TextStyle(fontSize: 20)),
        DropdownButton(
          icon: FaIcon(FontAwesomeIcons.caretDown),
          items: dropdownItems,
          onChanged: (taskTag) {
            context.read<AddTaskViewModel>().setSelectedTaskTag(taskTag!);
          },
          value: context.watch<AddTaskViewModel>().selectedTaskTag,
        ),
      ],
    );
  }

  List<DropdownMenuItem<TaskTags>> get dropdownItems {
    List<DropdownMenuItem<TaskTags>> items = [
      DropdownMenuItem(child: Text(LocaleKeys.home.tr()), value: TaskTags.home),
      DropdownMenuItem(child: Text(LocaleKeys.work.tr()), value: TaskTags.work),
      DropdownMenuItem(
          child: Text(LocaleKeys.personal.tr()), value: TaskTags.personal),
    ];
    return items;
  }
}
