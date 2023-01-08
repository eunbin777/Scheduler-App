import 'package:Scheduler/view/AddItemButton.dart';
import 'package:flutter/material.dart';
import 'package:Scheduler/schedule/Schedule.dart';
import 'package:Scheduler/todo/Todo.dart';
import 'package:Scheduler/view/ShowUser.dart';
import 'package:Scheduler/view/Calendar.dart';
import 'package:Scheduler/view/AppDrawer.dart';

class View extends StatefulWidget {
  final String email;
  final String viewType;

  const View(this.email, this.viewType, {Key? key}) : super(key: key);

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
            child: ShowUser(user)
          ),
          const Calendar(),
          ////구분선//////
          // Container(
          //   margin: EdgeInsets.only(
          //     top: 0.03 * height
          //   ),
          //   child: const Divider(
          //     thickness: 1.0,
          //     height: 1.0,
          //     color: Colors.grey,
          //   )
          // ),
        ]
      ),
      floatingActionButton: const AddItemButton(),
    );
  }
}