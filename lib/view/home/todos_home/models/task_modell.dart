// To parse this JSON data, do
//
//     final baseModel = baseModelFromMap(jsonString);

import 'dart:convert';

import 'package:todo_app/view/home/todos_home/models/task_model.dart';

class BaseModel {
  BaseModel({
    required this.data,
  });

  final Data data;

  BaseModel copyWith({
    Data? data,
  }) =>
      BaseModel(
        data: data ?? this.data,
      );

  factory BaseModel.fromJson(String str) => BaseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BaseModel.fromMap(Map<String, dynamic> json) => BaseModel(
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };
}

class Data {
  Data({
    required this.id,
    required this.user,
  });

  final int id;
  final User user;

  Data copyWith({
    int? id,
    User? user,
  }) =>
      Data(
        id: id ?? this.id,
        user: user ?? this.user,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        user: User.fromMap(json["attributes"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "attributes": user.toMap(),
      };
}

class User {
  User({
    required this.username,
    required this.email,
    required this.age,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.tasks,
  });

  final String username;
  final String email;
  final int age;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;
  final List<dynamic> tasks;

  User copyWith({
    String? username,
    String? email,
    int? age,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? publishedAt,
    List<dynamic>? tasks,
  }) =>
      User(
        username: username ?? this.username,
        email: email ?? this.email,
        age: age ?? this.age,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        publishedAt: publishedAt ?? this.publishedAt,
        tasks: tasks ?? this.tasks,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        username: json["username"],
        email: json["email"],
        age: json["age"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
        tasks: (json["tasks"]["data"] as List<dynamic>).map((x) => TaskModel.fromJson(x["id"], x["attributes"])).toList(),
      );

  Map<String, dynamic> toMap() => {
        "username": username,
        "email": email,
        "age": age,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
        "tasks": tasks.map((e) => e.toMap()),
      };
}

class Attributes {
  Attributes({
    required this.taskName,
    required this.createdDate,
    required this.lastChangeDate,
    required this.isFinished,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  final String taskName;
  final DateTime createdDate;
  final DateTime lastChangeDate;
  final bool isFinished;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;

  Attributes copyWith({
    String? taskName,
    DateTime? createdDate,
    DateTime? lastChangeDate,
    bool? isFinished,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? publishedAt,
  }) =>
      Attributes(
        taskName: taskName ?? this.taskName,
        createdDate: createdDate ?? this.createdDate,
        lastChangeDate: lastChangeDate ?? this.lastChangeDate,
        isFinished: isFinished ?? this.isFinished,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        publishedAt: publishedAt ?? this.publishedAt,
      );

  factory Attributes.fromJson(String str) => Attributes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Attributes.fromMap(Map<String, dynamic> json) => Attributes(
        taskName: json["taskName"],
        createdDate: DateTime.parse(json["createdDate"]),
        lastChangeDate: DateTime.parse(json["lastChangeDate"]),
        isFinished: json["isFinished"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "taskName": taskName,
        "createdDate": createdDate.toIso8601String(),
        "lastChangeDate": lastChangeDate.toIso8601String(),
        "isFinished": isFinished,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
      };
}
