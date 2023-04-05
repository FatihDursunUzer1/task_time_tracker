import 'package:flutter/material.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task.dart';

class TaskViewModel extends ChangeNotifier {
  Task _currentTask = Task.init();

  Task get currentTask => _currentTask;
  void set currentTask(Task task) {
    _currentTask = task;
    notifyListeners();
  }
}
