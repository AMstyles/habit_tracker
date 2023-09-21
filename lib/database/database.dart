//handle all the database related stuff usiing hive
import 'package:hive/hive.dart';
import '../Models/task.dart';

class Database{

  static Future<void> addTask(Task task) async{
    final box = Hive.box('tasks');
    box.add(task.toMap());
  }

  static Future<List<Task>> getAllTasks() async{
    print("getting all tasks...");
    final box = Hive.box('tasks');
    print("opened box $box of lenghth ${Hive.box('tasks').length}");
    final List<Task> tasks = [];
    print("created empty list of tasks");
    for(int i = 0; i < box.length; i++){
      Task newTask = Task.fromMap(box.getAt(i));
      tasks.add(newTask);
      print(newTask.name);
    }
    return tasks;
  }

}