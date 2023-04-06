import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task_tags.dart';
import 'package:task_time_tracker/infrastructure/repositories/task_repository.dart';
import 'package:task_time_tracker/infrastructure/repositories/user_repository.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
          onTap: () {
            TaskRepository.instance.addTask(Task(
                tags: [TaskTags.home, TaskTags.work],
                title: 'test',
                description: 'aa',
                userId: 'www',
                id: 'wwww'));
          },
          child: Text('AddTask')),
    );
  }
}
