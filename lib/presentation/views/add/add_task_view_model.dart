import 'package:flutter/material.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task_tags.dart';
import 'package:task_time_tracker/infrastructure/repositories/task_repository.dart';
import 'package:task_time_tracker/infrastructure/repositories/user_repository.dart';

class AddTaskViewModel extends ChangeNotifier {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  TaskRepository _taskRepository = TaskRepository.instance;
  UserRepository _userRepository = UserRepository.instance;

  final formKey = GlobalKey<FormState>();

  TaskTags _selectedTaskTag = TaskTags.home;
  TaskTags get selectedTaskTag => _selectedTaskTag;
  void setSelectedTaskTag(TaskTags taskTag) {
    _selectedTaskTag = taskTag;
    notifyListeners();
  }

  Future<Task> addTask() async {
    var userId = await _userRepository.getCurrentUser();

    await _taskRepository.addTask(Task(
        title: titleEditingController.text,
        description: descriptionEditingController.text,
        tags: [_selectedTaskTag],
        userId: userId!.id,
        createdAt: DateTime.now()));
    var task = Task(
        title: titleEditingController.text,
        description: descriptionEditingController.text,
        tags: [_selectedTaskTag],
        userId: userId.id,
        createdAt: DateTime.now());
    _clear();

    return task;
  }

  _clear() {
    titleEditingController.clear();
    descriptionEditingController.clear();
    _selectedTaskTag = TaskTags.home;
  }
}
