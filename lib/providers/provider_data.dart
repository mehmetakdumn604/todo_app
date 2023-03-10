import 'package:flutter/foundation.dart';
import 'package:todo_app/services/api_service.dart';
import 'package:todo_app/view/home/todos_home/models/task_model.dart';
import 'package:todo_app/view/home/todos_home/models/task_modell.dart';

class ProviderData extends ChangeNotifier {

  List<TaskModel> _tasks = [];

  User? _currentUser;
  User? get currentUser => _currentUser;

  set currentUser(User? value) {
    _currentUser = value;
    notifyListeners();
  }

  List<TaskModel> get tasks {
    return _tasks;
  }

  set tasks(List<TaskModel> value) {
    value.sort(
      (a, b) => b.createdDate.compareTo(a.createdDate),
    );
    value.sort(
      (a, b) => a.isFinished ? 1 : 0,
    );
    _tasks = value;
    notifyListeners();
  }

  void updateTaskLocation(TaskModel taskModel) {
    _tasks.remove(taskModel);
    if (taskModel.isFinished) {
      _tasks.add(taskModel);
    } else {
      _tasks.insert(0, taskModel);
    }
    _tasks.sort(
      (a, b) => a.lastChangeDate.compareTo(b.lastChangeDate),
    );
    _tasks.sort(
      (a, b) => a.isFinished ? 1 : 0,
    );
    notifyListeners();
  }

  void addTask(TaskModel taskModel) async {
    StrApiService.addTask(taskModel, this);
    _tasks.insert(0, taskModel);

    notifyListeners();
  }

  void removeTask(TaskModel task) async {
    StrApiService.deleteTask(task, this);
    _tasks.remove(task);

    notifyListeners();
  }
}
