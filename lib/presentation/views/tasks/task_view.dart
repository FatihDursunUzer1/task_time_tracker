import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task.dart';
import 'package:task_time_tracker/presentation/generated/locale_keys.g.dart';
import 'package:task_time_tracker/presentation/views/tasks/task_view_model.dart';
import 'package:task_time_tracker/presentation/widgets/custom_button.dart';
import 'package:task_time_tracker/presentation/widgets/functional_app_bar.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  void initState() {
    super.initState();
  }

  String format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(LocaleKeys.timer_reset_question.tr()),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    if (!context
                        .read<TaskViewModel>()
                        .currentTask
                        .isCompleted!) {
                      context.read<TaskViewModel>().resetTask();
                    }
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
          appBar: AppBar(
              title: Text(context.read<TaskViewModel>().currentTask.title)),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                context.read<TaskViewModel>().currentTask.description,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              stopWatch(context),
              context.read<TaskViewModel>().currentTask.isCompleted!
                  ? Container()
                  : TimeIconsRow(context),
            ],
          )),
    );
  }

  Text stopWatch(BuildContext context) {
    return Text(format(context.read<TaskViewModel>().currentTask.spendTime!),
        style: TextStyle(fontSize: 30));
  }

  Row TimeIconsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        !context.watch<TaskViewModel>().isStarted
            ? IconButton(
                onPressed: () {
                  context.read<TaskViewModel>().startTimer();
                },
                icon: const FaIcon(FontAwesomeIcons.solidPlayCircle, size: 50))
            : IconButton(
                onPressed: () {
                  context.read<TaskViewModel>().stopTimer();
                },
                icon:
                    const FaIcon(FontAwesomeIcons.solidPauseCircle, size: 50)),
        IconButton(
            onPressed: () {
              context.read<TaskViewModel>().stopTimer();
              context.read<TaskViewModel>().saveTask();
            },
            icon: FaIcon(FontAwesomeIcons.solidStopCircle, size: 50)),
      ],
    );
  }

  appBarActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.read<TaskViewModel>().currentTask.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          context.read<TaskViewModel>().currentTask.tags![0].toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
