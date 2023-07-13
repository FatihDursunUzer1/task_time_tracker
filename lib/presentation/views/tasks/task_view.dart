import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/presentation/generated/locale_keys.g.dart';
import 'package:task_time_tracker/presentation/views/tasks/task_view_model.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  String format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var task = context.read<TaskViewModel>().currentTask;
        if (task.spendTime != Duration.zero && task.isCompleted != true) {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(LocaleKeys.timer_reset_question.tr()),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  resetTimerAndGoBack(context),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text(LocaleKeys.no.tr()),
                  ),
                ],
              );
            },
          );
          return shouldPop!;
        }
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(context.read<TaskViewModel>().currentTask.title),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                      context.read<TaskViewModel>().currentTask.tags![0].name),
                ),
              )
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                context.read<TaskViewModel>().currentTask.description,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              stopWatch(context),
              !context.read<TaskViewModel>().currentTask.isCompleted!
                  ? ManageTimerRows(context)
                  : Container(),
            ],
          )),
    );
  }

  TextButton resetTimerAndGoBack(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (!context.read<TaskViewModel>().currentTask.isCompleted!) {
          context.read<TaskViewModel>().resetTask();
        }
        Navigator.pop(context, true);
      },
      child: Text(LocaleKeys.yes.tr()),
    );
  }

  stopWatch(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/timer.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
            format(context.read<TaskViewModel>().currentTask.spendTime!),
            style: const TextStyle(fontSize: 30)),
      ),
    );
  }

  Row ManageTimerRows(BuildContext context) {
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
            icon: const FaIcon(FontAwesomeIcons.solidStopCircle, size: 50)),
      ],
    );
  }

  appBarActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.read<TaskViewModel>().currentTask.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          context.read<TaskViewModel>().currentTask.tags![0].toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
