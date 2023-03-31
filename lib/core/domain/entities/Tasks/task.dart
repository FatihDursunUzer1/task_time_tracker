import 'dart:core';

import 'package:task_time_tracker/core/domain/entities/Tasks/task_tags.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_time_tracker/core/domain/entities/abstracts/IEntity.dart';

part 'task.g.dart';

@JsonSerializable()
class Task implements IEntity<Task> {
  late String icon;
  late String title;
  late String description;
  List<TaskTags>? tags;
  late Duration? duration;
  late bool isCompleted;

  @override
  late final String id;

  Task.init();

  Task({
    required this.icon,
    required this.title,
    required this.description,
    this.tags,
    required this.id,
    required this.duration,
    required this.isCompleted,
  });

  @override
  Task fromJson(Map<String, dynamic> json) {
    return _$TaskFromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Task entity) {
    return _$TaskToJson(entity);
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
