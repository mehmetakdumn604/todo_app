import 'dart:convert';
import 'dart:developer';

import 'package:gits_http/gits_http.dart';
import 'package:gits_strapi/gits_strapi.dart';
import 'package:todo_app/providers/provider_data.dart';
import 'package:todo_app/view/home/todos_home/models/task_model.dart';

import 'package:todo_app/view/home/todos_home/models/task_modell.dart';

class StrApiService {
  static final StrApiService _instance = StrApiService._init();
  GitsStrapi? _gitsStrapi;
  static StrApiService get instance => _instance;

  static strApiInit() {
    instance._gitsStrapi ??= GitsStrapi(
      timeout: 30000,
      showLog: true,
      gitsInspector: GitsInspector(),
      headers: _HEADERS,
    );
    return instance._gitsStrapi;
  }

  StrApiService._init();

  static const String BASE_URL = "http://localhost:1337/api";
  static const String TOKEN =
      "7ea6ef5d38f298152cc0173672240e6c5785d623ac0211e9143f99421999135bccdef91b0dcba57f0a35ff6bf71dffaa21c9e78e9298bcac201e88cf84fdf63ad88e2fd55db9fa393127202accad153fbf2e7a3b5919a88a27ac675ef333602543538ebdb1d1e5046a7b117ac85b28d83522d504693e1e1e527624bb9f703eb0";

  static const Map<String, String> _HEADERS = {
    "Authorization": "Bearer $TOKEN",
    "Content-Type": "application/json; charset=UTF-8",
  };
  static Future<void> addTask(TaskModel taskModel, ProviderData data) async {
    try {
      var insertBody = {
        "data": taskModel.toMap(),
      };

      Response insert = await _instance._gitsStrapi!.create(
        endpoint: Uri.parse("$BASE_URL/tasks"),
        body: insertBody,
      );
      log("CreateResponse : ${insert.body}");
      linkTaskWithUser(data, jsonDecode(insert.body)["data"]["id"]);
    } catch (e) {
      log("error");

      log(e.toString());
    }
  }

  static Future<void> deleteTask(TaskModel taskModel, ProviderData data) async {
    try {
      User currentUser = data.currentUser!;
      currentUser.tasks.remove(taskModel);

      Response removeTask = await instance._gitsStrapi!.delete(endpoint: Uri.parse("$BASE_URL/tasks"), id: taskModel.id.toString());
      log("DeleteResponse : ${removeTask.body}");
      unlinkTaskWithUser(data, jsonDecode(removeTask.body)["data"]["id"]);
    } catch (e) {
      log("error");

      log(e.toString());
    }
  }

  static Future<void> updateTask(TaskModel taskModel) async {
    try {
      var updateBody = {
        "data": taskModel.toMap(),
      };

      Response updateTaskRes = await instance._gitsStrapi!.update(
        endpoint: Uri.parse("$BASE_URL/tasks"),
        id: taskModel.id.toString(),
        body: updateBody,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<List<TaskModel>?> getTasks() async {
    try {
      CollectionResponse<DataResponse<dynamic>> tasksResponse = await _instance._gitsStrapi!.getCollection(
        endpoint: Uri.parse("$BASE_URL/tasks?sort[0]=lastChangeDate%3Adesc"),
      );
      log(tasksResponse.data.toString());
      return tasksResponse.data?.map((e) => TaskModel.fromJson(e.id!, e.attributes)).toList();
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<User> getCurrentUser(ProviderData data) async {
    try {
      var userResponse = await _instance._gitsStrapi!.getSingle(
        endpoint: Uri.parse(
          "$BASE_URL/customers/1?populate=*",
        ),
      );

      log("message");
      User userModel = User.fromMap(userResponse.data!.attributes);
      //UserModel userModel = UserModel.fromJson(response.body);
      data.currentUser = userModel;
      data.tasks = userModel.tasks as List<TaskModel>;
      return userModel;
    } catch (e) {
      log("error");

      log(e.toString());
      rethrow;
    }
  }

  static Future<void> linkTaskWithUser(ProviderData data, int taskId) async {
    try {
      User user = data.currentUser!;
      // todo change 1 with user.id
      await instance._gitsStrapi!.http.put(Uri.parse("$BASE_URL/customers/1?populate=*"), body: {
        "data": {
          "tasks": {
            "connect": [
              {"id": taskId}
            ]
          }
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> unlinkTaskWithUser(ProviderData data, int taskId) async {
    try {
      User user = data.currentUser!;
      // todo change 1 with user.id
      await instance._gitsStrapi!.http.put(Uri.parse("$BASE_URL/customers/1?populate=*"), body: {
        "data": {
          "tasks": {
            "disconnect": [
              {"id": taskId}
            ]
          }
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
