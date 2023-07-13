import 'package:flutter/material.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task.dart';
import 'package:task_time_tracker/core/domain/entities/Users/custom_user.dart';
import 'package:task_time_tracker/infrastructure/repositories/task_repository.dart';

class HomeViewModel extends ChangeNotifier {
  late CustomUser _currentUser;
  final TaskRepository _taskRepository = TaskRepository.instance;

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

  void addTask(Task task) {
    _currentTasks.add(task);
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

  Future<List<Task>> getTasks() async {
    _currentTasks = (_taskFilterDay == TaskFilterDay.all)
        ? await _taskRepository.getTasksByUser(_currentUser.id!)
        : await _taskRepository.getTodayTasksByUser(_currentUser.id!);
    notifyListeners();
    return _currentTasks;
  }

  Future<void> updateTask(Task task) async {
    await _taskRepository.updateTask(task.toJson());
    notifyListeners();
  }

  Future<void> deleteTask(Task task) async {
    await _taskRepository.deleteTask(task.id!);
    _currentTasks.remove(task);
    notifyListeners();
  }
}

enum TaskFilterDay { today, all }
