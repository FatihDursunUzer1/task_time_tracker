import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_time_tracker/core/application/navigation/navigation_service.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task.dart';
import 'package:task_time_tracker/infrastructure/repositories/task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  bool _isStarted = false;
  bool get isStarted => _isStarted;
  Timer? _timer;
  final TaskRepository _taskRepository = TaskRepository.instance;

  void startTimer() {
    _isStarted = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentTask.spendTime =
          _currentTask.spendTime! + const Duration(seconds: 1);
      notifyListeners();
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _isStarted = false;
    notifyListeners();
  }

  set isStarted(bool isStarted) {
    _isStarted = isStarted;
    notifyListeners();
  }

  late Task _currentTask;

  Task get currentTask => _currentTask;
  set currentTask(Task task) {
    _currentTask = task;
    notifyListeners();
  }

  saveTask() {
    _currentTask.isCompleted = true;
    notifyListeners();
    _taskRepository.updateTask(_currentTask.toJson());
    resetTask();
    NavigationService.instance.navigateToPageClear('/home');
  }

  resetTask() {
    _currentTask.spendTime = const Duration();
    stopTimer();
    notifyListeners();
  }
}
