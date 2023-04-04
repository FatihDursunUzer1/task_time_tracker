import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task.dart';

class TaskRepository {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static TaskRepository? _instance;

  static TaskRepository get instance {
    _instance ??= TaskRepository._privateConstructor();
    return _instance!;
  }

  TaskRepository._privateConstructor();

  Future<void> addTask(Map<String, dynamic> task) async {
    await _firestore.collection('tasks').add(task);
  }

  Future<void> updateTask(Map<String, dynamic> task) async {
    await _firestore.collection('tasks').doc(task['id']).update(task);
  }

  Future<void> deleteTask(String id) async {
    await _firestore.collection('tasks').doc(id).delete();
  }

  getTasks() {
    return _firestore.collection('tasks').withConverter(
        fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
        toFirestore: (task, _) => task.toJson(task));
  }

  Stream<QuerySnapshot> getTasksByUser(String userId) {
    return _firestore
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .snapshots();
  }
}
