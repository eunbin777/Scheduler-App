import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:term_project/AddSchedule.dart';
import 'package:term_project/AddTodo.dart';
import 'package:term_project/AppDrawer.dart';
import 'package:term_project/Schedule.dart';
import 'package:term_project/Todo.dart';
import 'package:term_project/Event.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Calendar extends StatefulWidget {
  final String id;
  final String password;

  Calendar(@required this.id, @required this.password, {Key? key}) : super(key: key);

  _Calendar createState() => _Calendar();
}

class _Calendar extends State<Calendar> {  
  // Schedule schedule = new Schedule("", "", "", "", "");
  // Map<DateTime, List<Schedule>> ScheduleList;
  // Map<DateTime, List<Todo>> TodoList;
  // Event event;
  Map<DateTime, List<Schedule>> scheduleList = {};
  Map<DateTime, List<Todo>> todoList = {};

  CalendarFormat format = CalendarFormat.month;

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().weekday,
  ); 

  DateTime focusedDay = DateTime.now();

  // TextEditingController _eventController = TextEditingController();
  // TextEditingController _TodoController = TextEditingController();

  // @override
  // void dispose() {
  //   // _eventController.dispose();
  //   _TodoController.dispose();
  //   super.dispose();
  // }

  // add schedule
  // Map<DateTime, List<Schedule>> scheduleList = {

  // };

  // Map<DateTime, List<Todo>> TodoList = {

  // };

  // @override
  // void initState() {
  //   // ScheduleList = {};
  //   // TodoList = {};
  //   // event = Event(scheduleList: ScheduleList, TodoList: TodoList);
  //   EventList = {};
  //   super.initState();
  // }

  List<Schedule> _getSchedulesForDay(DateTime day) {
    return scheduleList[day] ?? [];
  }

  List<Todo> _getTodosForDay(DateTime day) {
    return todoList[day] ?? [];
  }
  // List<Schedule> _getSchedulesForDay(DateTime day) {
  //   return ScheduleList[day] ?? [];
  // }

  // List<Todo> _getTodosForDay(DateTime day) {
  //   return TodoList[day] ?? [];
  // }

  // List<Event> _getEventsForDay(DateTime day) {
  //   return events[day] ?? [];
  // }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    String weekday = DateFormat('E', 'ko').format(selectedDay);

    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(),
      drawer: AppDrawer(widget.id),
      body: Column(
        children: [
          TableCalendar(
            locale : 'ko_KR',
            firstDay: DateTime.utc(2021, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: focusedDay,
            calendarStyle: CalendarStyle(
              markerSize: 10.0,
              markerDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle
              ),
            ),
            eventLoader: _getSchedulesForDay,
            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
              // 선택 날짜 갱신
              setState((){
                this.selectedDay = selectedDay;
                this.focusedDay = focusedDay;
              });
            },
            selectedDayPredicate: (DateTime day) {
              // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.	
              return isSameDay(selectedDay, day);
            },
            /* calendar format update */
            calendarFormat: format,
            onFormatChanged: (CalendarFormat format) {
              setState(() {
                this.format = format;
              });
            },
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0 * fem, 15 * fem, 0 * fem, 12 * fem),
            width: 320 * fem,
            height: 22 * fem,
            // decoration: BoxDecoration (
            //           color: Color(0xffd9d9d9),
            //           borderRadius: BorderRadius.circular(10 * fem),
            //         ),
            child: Text(
              '${DateFormat("yyyy년 MM월 dd일 ").format(selectedDay)}($weekday)',
              style: GoogleFonts.lato(
                fontSize: 16 * ffem,
                fontWeight: FontWeight.w700,
                height: 1.5 * ffem / fem,
                color: Color(0xff000000),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          ..._getSchedulesForDay(selectedDay).map((Schedule s) => ListTile(
            title: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(15 * fem, 13 * fem, 0 * fem, 0 * fem),
                    width: 115 * fem,
                    height: 18 * fem,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(width: 5 * ffem, color: Colors.black)
                      )
                    ),
                    child: Text(
                      '${s.startTime} ~ ${s.endTime}',
                      style: TextStyle(
                        fontSize: 13 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.2125 * ffem / fem,
                        color: Color(0xff000000),
                      ),
                    )
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10 * fem, 13 * fem, 0 * fem, 0 * fem),
                    width: 180 * fem,
                    height: 18 * fem,
                    child: Text(
                      '${s.title}',
                      style: TextStyle(
                        fontSize: 13 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.2125 * ffem / fem,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),),  // map
          ..._getTodosForDay(selectedDay).map((Todo t) => ListTile(
            title: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                              value: t.isDone,
                              onChanged: (value) {
                                setState(() {
                                  t.isDone = value;
                                });
                              },
                            ),
                            Text('${t.task}'),
                          ],
                        ),
                      ],
                    )
                  ),
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: todoList.length,
                  //     itemBuilder: (context, index) {
                  //       return Card(
                  //         child: CheckboxListTile(
                  //           title: Text(t.task),
                  //           value: t.isDone,
                  //           onChanged: (val) {
                  //             setState(() {
                  //               t.isDone = false;
                  //               print(index);
                  //             },);
                  //           },
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          )),  //map
        ]
      ), 
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('선택'),
            content: Text('추가할 item의 종류를 선택해주세요'),
            actions: [
              TextButton(
                child: Text('일정'),
                onPressed: () async {
                  final schedule = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddSchedule(selectedDay)
                    )
                  );
                  Navigator.pop(context);
                  if(scheduleList[selectedDay] != null) {
                    scheduleList[selectedDay]?.add(schedule);
                  }
                  else {
                    scheduleList[selectedDay] = [schedule];
                  }
                }
              ),
              TextButton(
                child: Text("할 일"),
                onPressed: () async {
                  final todo = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTodo(selectedDay)
                    )
                  );
                  Navigator.pop(context);
                  if(todoList[selectedDay] != null) {
                    todoList[selectedDay]?.add(todo);
                  }
                  else {
                    todoList[selectedDay] = [todo];
                  }
                }
              ),
              TextButton(
                child: Text("취소"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          )
        ),
        label: Text("+"),
        // onPressed: () async {
        //   final schedule = await Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => AddEvent(selectedDay)
        //     )
        //   );
        //   if(scheduleList[selectedDay] != null) {
        //     scheduleList[selectedDay]?.add(schedule);
        //   }
        //   else {
        //     scheduleList[selectedDay] = [schedule];
        //   }
        // },
      ),
    );
  }
}