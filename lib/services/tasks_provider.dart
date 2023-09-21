import 'package:flutter/cupertino.dart';
import 'package:habit_tracker/database/database.dart';
import '../Models/task.dart';

class TaskProvider with ChangeNotifier {
  Future<List<Task>> _tasks = Database.getAllTasks();

  TaskProvider() {
    _tasks = Database.getAllTasks();
  }

  Future<List<Task>> get tasks => _tasks;

  Future<void> addTask(Task task) async{
    await Database.addTask(task);
    refresh();
    notifyListeners();
  }

  refresh() {
    _tasks = Database.getAllTasks();
    notifyListeners();
  }

}