import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task.dart';

class TaskViewModel extends ChangeNotifier {
  bool _isStarted = false;
  bool get isStarted => _isStarted;
  Duration _duration = Duration();
  Timer? _timer;

  Duration get duration => _duration;

  void startTimer() {
    _isStarted = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _duration = _duration + Duration(seconds: 1);
      notifyListeners();
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _isStarted = false;
    notifyListeners();
  }

  void set isStarted(bool isStarted) {
    _isStarted = isStarted;
    notifyListeners();
  }

  Task _currentTask = Task.init();

  Task get currentTask => _currentTask;
  void set currentTask(Task task) {
    _currentTask = task;
    notifyListeners();
  }
}
