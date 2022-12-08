import 'package:flutter/material.dart';
import 'package:term_project/Schedule.dart';
import 'package:term_project/Todo.dart';

class Event{
  Map<DateTime, List<Schedule>> scheduleList;
  Map<DateTime, List<Todo>> TodoList;

  Event({required this.scheduleList, required this.TodoList});
}