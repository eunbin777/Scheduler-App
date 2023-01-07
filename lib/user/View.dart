import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Scheduler/calendar/MonthlyView.dart';
import 'package:Scheduler/schedule/Schedule.dart';
import 'package:Scheduler/todo/Todo.dart';
import 'package:Scheduler/user/AppDrawer.dart';


class View extends StatefulWidget {
  final String email;

  const View(this.email, {Key? key}) : super(key: key);

  @override
  ViewState createState() => ViewState();
}

class ViewState extends State<View> {  
  // Map<DateTime, List<Schedule>> scheduleList = {};
  // Map<DateTime, List<Todo>> todoList = {};

  // final DateTime focusedDay = DateTime.now(); 

  // CalendarFormat format = CalendarFormat.month;

  // DateTime selectedDay = DateTime(
  //   DateTime.now().year,
  //   DateTime.now().month,
  //   DateTime.now().day,
  //   DateTime.now().weekday,
  // ); 

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

    // String weekday = DateFormat('E', 'ko').format(selectedDay);

    return Scaffold(
      resizeToAvoidBottomInset : false,
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
            margin: const EdgeInsets.only(
              bottom: 15.0,
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    right: 20.0,
                  ),
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('images/user.png'),
                    backgroundColor: Colors.white,
                  ),
                ),
                Text(
                  user
                ),
              ],
            ),
          ),
          // Row(
          //   children: [
          //     CircleAvatar(
          //       backgroundImage: AssetImage('images/user.png'),
          //       backgroundColor: Colors.white,
          //     ),
          //   ],
          // ),
          const MonthlyView(),
        ]
      )
    );
  }
}