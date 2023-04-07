import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task_tags.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_time_tracker/core/domain/entities/abstracts/IEntity.dart';

part 'task.g.dart';

@JsonSerializable()
class Task implements IEntity<Task> {
  late String title;
  late String description;
  List<TaskTags>? tags;
  late String userId;
  late DateTime createdAt;

  @override
  late String id;

  Task.init();

  Task(
      {required this.title,
      required this.description,
      required this.tags,
      required this.userId,
      required this.createdAt});

  @override
  Task fromJson(Map<String, dynamic> json) {
    return _$TaskFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$TaskToJson(this);
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
