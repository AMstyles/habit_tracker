import 'package:flutter/material.dart';

class Reminder {
  int? id;
  String name;
  String? description;
  DateTime? date;
  bool isDone;
  int color;
  Color? _color;

  Reminder(this.name, this.isDone, this.color);
}

List<Reminder> reminders = [
  Reminder('Feed cat', false, 1),
  Reminder('Car Wash', true, 5),
  Reminder('Call Dan', false, 8),
  Reminder('water Garden', false, 12),
  Reminder('Go to gym', false, 16),
  Reminder('Read emails', false, 23),
  Reminder('Go shopping', false, 20),
];
