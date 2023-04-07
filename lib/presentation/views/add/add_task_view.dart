import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/application/constants/validators.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task_tags.dart';
import 'package:task_time_tracker/infrastructure/repositories/task_repository.dart';
import 'package:task_time_tracker/infrastructure/repositories/user_repository.dart';
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
        child: Column(
          children: [
            Text(
              'Add Task',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            TextFormField(
              validator: Validators.checkEmptyText,
              controller:
                  context.read<AddTaskViewModel>().titleEditingController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            Divider(),
            TextFormField(
              validator: Validators.checkEmptyText,
              controller:
                  context.read<AddTaskViewModel>().descriptionEditingController,
              decoration: InputDecoration(
                labelText: 'Description',
                floatingLabelAlignment: FloatingLabelAlignment.center,
                floatingLabelStyle: TextStyle(fontSize: 20),
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
                text: 'Add Task'),
          ],
        ),
      ),
    );
  }

  DropdownButton<TaskTags> TaskTagDropdownButton(BuildContext context) {
    return DropdownButton(
      items: dropdownItems,
      onChanged: (taskTag) {
        context.read<AddTaskViewModel>().setSelectedTaskTag(taskTag!);
      },
      value: context.watch<AddTaskViewModel>().selectedTaskTag,
    );
  }

  List<DropdownMenuItem<TaskTags>> get dropdownItems {
    List<DropdownMenuItem<TaskTags>> items = [
      DropdownMenuItem(child: Text('Home'), value: TaskTags.home),
      DropdownMenuItem(child: Text('Work'), value: TaskTags.work),
      DropdownMenuItem(child: Text('Personal'), value: TaskTags.personal),
    ];
    return items;
  }
}
