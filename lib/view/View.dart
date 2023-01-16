import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:Scheduler/schedule/ModifyScheduleForm.dart';
import 'package:Scheduler/schedule/AddSchedule.dart';
import 'package:Scheduler/schedule/Schedule.dart';
import 'package:Scheduler/todo/AddTodo.dart';
import 'package:Scheduler/todo/Todo.dart';
import 'package:Scheduler/todo/ModifyTodoForm.dart';
import 'package:Scheduler/view/ShowUser.dart';
import 'package:Scheduler/view/AppDrawer.dart';
import 'package:table_calendar/table_calendar.dart';

class View extends StatefulWidget {
  final String email;
  final String viewType;

  const View(this.email, this.viewType, {Key? key}) : super(key: key);

  @override
  ViewState createState() => ViewState();
}

class ViewState extends State<View> {  
  DateTime focusedDay = DateTime.now();

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().weekday,
  ); 

  CalendarFormat calendarFormat = CalendarFormat.month;

  Map<DateTime, List<Schedule>> scheduleList = {};
  Map<DateTime, List<Todo>> todoList = {};

  List<Schedule> _getSchedulesForDay(DateTime day) {
    return scheduleList[day] ?? [];
  }

  List<Todo> _getTodosForDay(DateTime day) {
    return todoList[day] ?? [];
  }

  FloatingActionButton AddItemButton(DateTime selectedDay) {
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
                    ),
                  );
                  navigator.pop();

                  // setState(() {
                  //   selectedDay = day_schedule["selectedDay"];
                  // });

                  // final schedule = day_schedule["schedule"];

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
                  print('selectedDay: $selectedDay');
                  print('title: ${scheduleList[selectedDay]![0].title}');
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
        label: const Icon(
          Icons.add,
          color: Colors.white,
        ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final String email = widget.email;
    final int index = email.indexOf('@');
    final String user = email.substring(0, index);

    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;
    final navigator = Navigator.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      endDrawer: AppDrawer(widget.email),
      body: Column(
        children: [
          Container(
            width: 0.9 * width,
            margin: const EdgeInsets.only(bottom: 15.0),
            child: ShowUser(user)
          ),
          Center(
            child: Container(
              width: 0.9 * width,
              padding: EdgeInsets.only(bottom: 0.01 * height),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.0),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              margin: const EdgeInsets.only(bottom: 20.0),
              child: TableCalendar(
                locale: 'ko_KR',
                focusedDay: focusedDay,
                firstDay: DateTime(1990),
                lastDay: DateTime(2030),
                calendarFormat: calendarFormat,
                availableCalendarFormats: const {
                  CalendarFormat.month: '월',
                  CalendarFormat.twoWeeks: '2주',
                  CalendarFormat.week: '1주',
                },
                onFormatChanged: (format) {
                  setState(() {
                    calendarFormat = format;
                  });
                },
                eventLoader: _getSchedulesForDay,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    this.selectedDay = selectedDay;
                    this.focusedDay = focusedDay;
                  });
                },
                selectedDayPredicate: (day) {
                  // change the shape of selected day
                  return isSameDay(selectedDay, day);
                },
                daysOfWeekHeight: 20.0,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: true,
                  titleCentered: false,
                  titleTextStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                calendarStyle: const CalendarStyle(
                  markerSize: 10.0,
                  markerDecoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  isTodayHighlighted: true,
                  todayTextStyle: TextStyle(
                    color: Colors.black,
                  ),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffe8e8e8),
                  ),
                  selectedTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  selectedDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffdcdcdc),
                  ),
                  holidayTextStyle: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            thickness: 1,
            height: 1,
            color: Colors.grey,
          ),
          Container(
            width: 0.9 * width,
            margin: const EdgeInsets.only(top: 15.0),
            child: Text(
              '${DateFormat('d.').format(selectedDay).toString()} (${DateFormat('E', 'ko').format(selectedDay)})',
              style: GoogleFonts.lato(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ), 
          ),
          ..._getSchedulesForDay(selectedDay).map((Schedule s) => ListTile(
            title: InkWell(
              onTap: () async {
                final modifySchedule = await navigator.push(
                  MaterialPageRoute(
                    builder: (_) => ModifyScheduleForm(selectedDay)
                  )
                );
                int index = scheduleList[selectedDay]!.indexOf(s);
                // print(scheduleList[selectedDay]![index].title);

                if (modifySchedule.title == "null") {
                  setState(() {
                    scheduleList[selectedDay]!.removeAt(index);
                  });
                }
                else {
                  setState(() {
                    scheduleList[selectedDay]!.fillRange(index, index + 1,modifySchedule);
                  });
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                    children: [
                      Text(
                        '${s.startTime} ~ ${s.endTime}',
                        style: const TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20.0),
                        margin: const EdgeInsets.only(left: 20.0),
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              width: 5.0,
                              color: Colors.black,
                            )
                          )
                        ),
                        child: Text(
                          s.title,
                          style: const TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                ),
              ),
            ),
          )),
          ..._getTodosForDay(selectedDay).map((Todo t) => ListTile(
            title: InkWell(
              onTap: () async {
                final modifyTodo = await navigator.push(
                  MaterialPageRoute(
                    builder: (_) => ModifyTodoForm(selectedDay)
                  )
                );
                int index = todoList[selectedDay]!.indexOf(t);

                if (modifyTodo.task == "null") {
                  setState(() {
                    todoList[selectedDay]!.removeAt(index);
                  });
                }
                else {
                  setState(() {
                    todoList[selectedDay]!.fillRange(index, index + 1, modifyTodo);
                  });
                }
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.black,
                        value: t.isDone,
                        onChanged: (value) {
                          setState(() {
                            t.isDone = value;
                            int index = todoList[selectedDay]!.indexOf(t);
                            todoList[selectedDay]!.removeAt(index);
                          });
                        },
                      ),
                      Text(
                        t.task,
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
        ]
      ),
      floatingActionButton: AddItemButton(selectedDay),
    );
  }
}