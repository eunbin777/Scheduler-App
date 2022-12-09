import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:term_project/AddEvent.dart';
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
  Map<DateTime, List<Object>> EventList = {};

  CalendarFormat format = CalendarFormat.month;

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().weekday,
  );

  DateTime focusedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

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

  List<Object> _getEventsForDay(DateTime day) {
    return EventList[day] ?? [];
  }
  // List<Schedule> _getSchedulesForDay(DateTime day) {
  //   return ScheduleList[day] ?? [];
  // }

  // List<Todo> _getTodosForDay(DateTime day) {
  //   return TodoList[day] ?? [];
  // }


  // Map<DateTime, List<Event>> events = {
  //   DateTime.utc(2022,12,13) : [ Event('title'), Event('title2') ],
  //   DateTime.utc(2022,12,14) : [ Event('title3') ],
  // };

  // List<Event> _getEventsForDay(DateTime day) {
  //   return events[day] ?? [];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            eventLoader: _getEventsForDay,
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
          ..._getEventsForDay(selectedDay).map((Object obj) => ListTile(
                title: Text(((obj) as Schedule).title),
              ),
            ),
        ]
      ),
      floatingActionButton: FloatingActionButton.extended(
        // onPressed: () => showDialog(
        //   context: context,
        //   builder: (context) => AlertDialog(
        //     title: Text("일정 등록"),
        //     content: TextFormField(controller: _eventController,),
        //     actions: [
        //       TextButton(
        //         child: Text("확인"),
        //         onPressed: () {
        //           if(_eventController.text.isEmpty) {
                    
        //           }
        //           else {
        //             if(EventList[selectedDay] != null) {
        //               EventList[selectedDay]?.add(Schedule(title: _eventController.text));
        //               // if(EventList[selectedDay])
        //             }
        //             else {
        //               EventList[selectedDay] = [Schedule(title: _eventController.text)];
        //             }
        //           }
        //           Navigator.pop(context);
        //           _eventController.clear();
        //           setState(() {
                    
        //           });
        //           return;
        //         },
        //       ),
        //       TextButton(
        //         child: Text("취소"),
        //         onPressed: () => Navigator.pop(context),
        //       ),
        //     ],
        //   )
        // ),



        
        onPressed: () async {
          final schedule = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEvent(selectedDay)
            )
          );
          print('schedule: ${schedule.title}');
        },
        label: Text("+"),
      ),
    );
  }
}