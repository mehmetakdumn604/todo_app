import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:todo_app/services/api_service.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/services/data_service.dart';

class TaskModel {
  int? id;
  final String taskName;
  bool isFinished;
  String createdDate, lastChangeDate;
  final String? createdUserId;

  TaskModel({
    this.id,
    required this.taskName,
    this.isFinished = false,
    required this.createdDate,
    required this.lastChangeDate,
    this.createdUserId,
  });

  factory TaskModel.fromJson(int id, Map json) {
    return TaskModel(
      id: id,
      taskName: json["taskName"],
      isFinished: json["isFinished"] ?? false,
      createdDate: json["createdDate"],
      lastChangeDate: json["lastChangeDate"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "taskName": taskName,
      "isFinished": isFinished,
      "createdDate": createdDate,
      "lastChangeDate": lastChangeDate,
      "createdUserId": AuthService.userId,
     
    };
  }

  void changeFinishedState() async {
    isFinished = !isFinished;
  lastChangeDate = DateTime.now().toIso8601String();
    if (isFinished) {
      await FlutterPlatformAlert.playAlertSound();
    }
    StrApiService.updateTask(this);
  }
}
