import 'package:flutter/foundation.dart';

class Todo {
  final String task;
  final bool? isDone;
  final DateTime? date;

  Todo({required this.task, this.isDone, this.date});
}