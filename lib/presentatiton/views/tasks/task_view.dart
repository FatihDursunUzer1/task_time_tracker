import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/presentatiton/views/tasks/task_view_model.dart';
import 'package:task_time_tracker/presentatiton/widgets/custom_button.dart';
import 'package:task_time_tracker/presentatiton/widgets/functional_app_bar.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FunctionalAppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Text(
                  context
                      .watch<TaskViewModel>()
                      .currentTask
                      .tags!
                      .first
                      .toString(),
                ),
                Text(
                  context
                      .watch<TaskViewModel>()
                      .currentTask
                      .duration
                      .toString(),
                ),
                CustomButton(
                    text: 'Finish',
                    onPressed: () {
                      //context.read<TaskViewModel>().finishTask();
                    }),
                TextButton(onPressed: () {}, child: const Text('Quit'))
              ],
            ),
          ),
        ));
  }
}
