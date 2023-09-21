import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String note;

  @HiveField(2)
  final DateTime time;

  @HiveField(3)
  bool isCompleted ;

  @HiveField(4)
  int color;

  Task({
    required this.name,
    required this.note,
    required this.time,
    required this.isCompleted,
    required this.color,
  });


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'note': note,
      'time': time.millisecondsSinceEpoch,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      color: map['color'],
      name: map['name'],
      note: map['note'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      isCompleted: map['isCompleted'],
    );
  }

  @override
  String toString() {
    return 'Task(name: $name, note: $note, time: $time, isCompleted: $isCompleted)';
  }


}

List<Task> tasks = [

  Task(name: 'Feed cat', note: 'feed the annoying cat now', time: DateTime.now(), isCompleted: false,  color: 1),
  Task(name: 'Wash the car', note: 'Wash apollo', time: DateTime.now(), isCompleted: false, color: 2),
  Task(name: 'Hit the gym', note: 'Wash apollo', time: DateTime.now(), isCompleted: false, color: 3),


];