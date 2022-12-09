import 'package:flutter/foundation.dart';

// class Todo {
//   final String task;
//   final bool? isDone;
//   final DateTime? date;

//   Todo({required this.task, this.isDone, this.date});
// }

class Todo {
  String task;
  bool isDone;
  DateTime date;

  Todo(this.task, this.isDone, this.date);
}