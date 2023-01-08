import 'package:flutter/material.dart';
import 'package:Scheduler/schedule/Schedule.dart';
import 'package:Scheduler/schedule/AddSchedule.dart';
import 'package:Scheduler/todo/Todo.dart';
import 'package:Scheduler/todo/AddTodo.dart';

class AddItemButton extends StatefulWidget {
  const AddItemButton({super.key});

  @override
  AddItemButtonState createState() => AddItemButtonState();
}

class AddItemButtonState extends State<AddItemButton> {
  Map<DateTime, List<Schedule>> scheduleList = {};
  Map<DateTime, List<Todo>> todoList = {};

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().weekday,
  ); 

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    return FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('추가'),
            content: const Text('아이템의 종류를 선택해주세요'),
            actions: [
              TextButton(
                child: const Text('일정'),
                onPressed: () async {
                  final schedule = await navigator.push(
                    MaterialPageRoute(
                      builder: (context) => AddSchedule(selectedDay)
                    )
                  );
                  navigator.pop();

                  if(scheduleList[selectedDay] != null) {
                    setState(() {
                      scheduleList[selectedDay]!.add(schedule);
                    });
                  }
                  else {
                    setState(() {
                      scheduleList[selectedDay] = [schedule];
                    });
                  }
                }
              ),
              TextButton(
                child: const Text("할 일"),
                onPressed: () async {
                  final todo = await navigator.push(
                    MaterialPageRoute(
                      builder: (context) => AddTodo(selectedDay)
                    )
                  );
                  navigator.pop();

                  if(todoList[selectedDay] != null) {
                    setState(() {
                      todoList[selectedDay]?.add(todo);
                    });
                  }
                  else {
                    setState(() {
                      todoList[selectedDay] = [todo];
                    });
                  }
                }
              ),
              TextButton(
                child: const Text("취소"),
                onPressed: () => Navigator.pop(context),
              ),
            ]
          ),
        ),
        backgroundColor: Colors.black,
        label: const Text(
          '+',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
    );
  }
}