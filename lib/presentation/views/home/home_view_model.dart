import 'package:flutter/material.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task.dart';
import 'package:task_time_tracker/core/domain/entities/Users/custom_user.dart';
import 'package:task_time_tracker/infrastructure/repositories/task_repository.dart';

class HomeViewModel extends ChangeNotifier {
  late CustomUser _currentUser;
  TaskRepository _taskRepository = TaskRepository.instance;

  CustomUser get currentUser => _currentUser;
  void setCurrentUser(CustomUser user) {
    _currentUser = user;
    //notifyListeners();
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

  getTasks() async {
    var tasks = (_taskFilterDay == TaskFilterDay.all)
        ? await _taskRepository.getTasksByUser(_currentUser.id)
        : await _taskRepository.getTodayTasksByUser(_currentUser.id);
    return tasks;
  }
}

enum TaskFilterDay { today, all }
