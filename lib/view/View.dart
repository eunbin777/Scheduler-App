import 'package:flutter/material.dart';
import 'package:Scheduler/schedule/Schedule.dart';
import 'package:Scheduler/todo/Todo.dart';
import 'package:Scheduler/view/ShowUser.dart';
import 'package:Scheduler/view/AddItemButton.dart';
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

  // Map<DateTime, List<Schedule>> scheduleList = {};
  // Map<DateTime, List<Todo>> todoList = {};

  // List<Schedule> _getSchedulesForDay(DateTime day) {
  //   return scheduleList[day] ?? [];
  // }

  // List<Todo> _getTodosForDay(DateTime day) {
  //   return todoList[day] ?? [];
  // }
  

  @override
  Widget build(BuildContext context) {
    final String email = widget.email;
    final int index = email.indexOf('@');
    final String user = email.substring(0, index);

    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;

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
              child: TableCalendar(
                locale: 'ko_KR',
                focusedDay: focusedDay,
                firstDay: DateTime(1990, 1, 1),
                lastDay: DateTime(2030, 12, 31),
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
          )
        ]
      ),
      floatingActionButton: AddItemButton(selectedDay),
    );
  }
}