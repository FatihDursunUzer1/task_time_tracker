import 'package:flutter/material.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task.dart';
import 'package:task_time_tracker/core/domain/entities/Users/custom_user.dart';

class HomeViewModel extends ChangeNotifier {
  late CustomUser _currentUser;

  CustomUser get currentUser => _currentUser;
  void setCurrentUser(CustomUser user) {
    _currentUser = user;
    notifyListeners();
  }

  late List<Task> _currentTasks;
  List<Task>? get currentTasks => _currentTasks;
  void setCurrentTasks(List<Task> tasks) {
    _currentTasks = tasks;
    notifyListeners();
  }

  int _currentNavBarIndex = 0;
  int get currentNavBarIndex => _currentNavBarIndex;
  void setCurrentNavBarIndex(int index) {
    _currentNavBarIndex = index;
    notifyListeners();
  }

  TaskFilterDay _taskFilterDay = TaskFilterDay.today;
  TaskFilterDay get taskFilterDay => _taskFilterDay;
  void setTaskFilterDay(TaskFilterDay taskFilterDay) {
    _taskFilterDay = taskFilterDay;
    notifyListeners();
  }

  getValues() {
    if (_taskFilterDay == TaskFilterDay.all) {
      return;
    } else {
      _currentTasks = _currentTasks
          .where((element) => element.createdAt.day == DateTime.now().day)
          .toList();
      notifyListeners();
    }
  }
}

enum TaskFilterDay { today, all }
