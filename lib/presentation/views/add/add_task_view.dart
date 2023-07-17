import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/application/constants/validators.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task_tags.dart';
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
    return SingleChildScrollView(
      child: Form(
        key: context.read<AddTaskViewModel>().formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.add_task.tr(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              TextFormField(
                validator: Validators.checkEmptyText,
                controller:
                    context.read<AddTaskViewModel>().titleEditingController,
                decoration: InputDecoration(
                  hintText: LocaleKeys.title.tr(),
                ),
              ),
              const Divider(),
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
                  onPressed: () async {
                    var currentState =
                        context.read<AddTaskViewModel>().formKey.currentState!;
                    if (currentState.validate()) {
                      currentState.save();
                      var task =
                          await context.read<AddTaskViewModel>().addTask();
                      context.read<HomeViewModel>().addTask(task);
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
        Text('${LocaleKeys.task_tags.tr()}: ',
            style: const TextStyle(fontSize: 20)),
        DropdownButton(
          icon: const FaIcon(FontAwesomeIcons.caretDown),
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
      DropdownMenuItem(value: TaskTags.home, child: Text(LocaleKeys.home.tr())),
      DropdownMenuItem(value: TaskTags.work, child: Text(LocaleKeys.work.tr())),
      DropdownMenuItem(
          value: TaskTags.personal, child: Text(LocaleKeys.personal.tr())),
    ];
    return items;
  }
}
