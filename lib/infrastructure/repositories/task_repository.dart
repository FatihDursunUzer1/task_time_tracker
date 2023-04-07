import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task.dart';

class TaskRepository {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static TaskRepository? _instance;

  static TaskRepository get instance {
    _instance ??= TaskRepository._privateConstructor();
    return _instance!;
  }

  TaskRepository._privateConstructor();

  Future<void> addTask(Task task) async {
    try {
      var doc = _firestore.collection('tasks').doc();
      task.id = doc.id;
      await doc
          .withConverter<Task>(
              fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
              toFirestore: (task, _) => task.toJson(task))
          .set(task);

      Fluttertoast.showToast(
          msg: 'Task added successfully', backgroundColor: Colors.green);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> updateTask(Map<String, dynamic> task) async {
    await _firestore
        .collection('tasks')
        .doc(task['id'])
        .withConverter<Task>(
            fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
            toFirestore: (task, _) => task.toJson(task))
        .update(task);
  }

  Future<void> deleteTask(String id) async {
    await _firestore.collection('tasks').doc(id).delete();
  }

  getTasks() async {
    final collection = await _firestore
        .collection('tasks')
        .withConverter<Task>(
            fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
            toFirestore: (task, _) => task.toJson(task))
        .get();
    return collection.docs.map((e) => e.data()).toList();
  }

  getTasksByUser(String userId) async {
    final collection = await _firestore
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .withConverter<Task>(
            fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
            toFirestore: (task, _) => task.toJson(task))
        .get();
    return collection.docs.map((e) => e.data()).toList();
  }

  getTodayTasksByUser(String userId) async {
    try {
      var date = DateTime.now().subtract(Duration(days: 1));
      final collection = await _firestore
          .collection('tasks')
          .where('userId', isEqualTo: userId)
          .where('createdAt', isGreaterThanOrEqualTo: date)
          .withConverter<Task>(
              fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
              toFirestore: (task, _) => task.toJson(task))
          .get();
      return collection.docs.map((e) => e.data()).toList();
    } catch (e) {
      print(e);
    }
  }
}
