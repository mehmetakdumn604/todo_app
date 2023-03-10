import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/view/home/todos_home/models/task_model.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

class DataService {
  static Future<void> addTask(TaskModel taskModel) async {
    try {
      //await _db.collection("tasks").add(taskModel.toMap()).then((value) => taskModel.id = value.id);
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }

  static Future<List<TaskModel>> getTasks() async {
    try {
      return await _db.collection("tasks").orderBy("isFinished").orderBy("lastChangeDate", descending: true).get().then((value) {
        log(value.docs.length.toString());
        return value.docs.map((e) => TaskModel.fromJson(int.tryParse(e.id) ?? 0, e.data())).toList();
      });
    } catch (e) {
      print(e.toString());
      log(e.toString());
      rethrow;
    }
  }

  static void removeTask(TaskModel task) async {
    try {
      await _db.collection("tasks").doc(task.id.toString()).delete();
    } catch (e) {
      log(e.toString());
    }
  }

  static void updateTask(TaskModel taskModel) async {
    try {
      await _db.collection("tasks").doc(taskModel.id.toString()).update({
        "isFinished": taskModel.isFinished,
        "lastChangeDate": taskModel.lastChangeDate,
      });
    } catch (e) {
      log("$e");
    }
  }
}
