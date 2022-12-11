import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:term_project/AddSchedule.dart';
import 'package:term_project/AddTodo.dart';
import 'package:term_project/AppDrawer.dart';
import 'package:term_project/ModifyScheduleForm.dart';
import 'package:term_project/Schedule.dart';
import 'package:term_project/Todo.dart';
// import 'package:firebase_auth/firebase_auth.dart';


class Calendar extends StatefulWidget {
  final String id;
  final String password;

  Calendar(@required this.id, @required this.password, {Key? key}) : super(key: key);

  _Calendar createState() => _Calendar();
}

class _Calendar extends State<Calendar> {  
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

  List<Schedule> _getSchedulesForDay(DateTime day) {
    return scheduleList[day] ?? [];
  }

  List<Todo> _getTodosForDay(DateTime day) {
    return todoList[day] ?? [];
  }

  // Schedule _schedule = new Schedule("", "", "", "", "");
  // Schedule _schedule;

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
            firstDay: DateTime.utc(2020, 03, 01),
            lastDay: DateTime.utc(2030, 12, 31),
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
            margin: EdgeInsets.fromLTRB(0 * fem, 15 * fem, 0 * fem, 10 * fem),
            width: 320 * fem,
            height: 22 * fem,
            child: Text(
              '${DateFormat("yyyy년 MM월 dd일 ").format(selectedDay)}($weekday)',
              style: GoogleFonts.lato(
                fontSize: 15 * ffem,
                fontWeight: FontWeight.w700,
                height: 1.5 * ffem / fem,
                color: Color(0xff000000),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          ..._getSchedulesForDay(selectedDay).map((Schedule s) => ListTile(
              //  title: InkWell(
              //   onTap: () async {
              //     final modifySchedule = await Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => ModifyScheduleForm(selectedDay)
              //       )
              //     );
              //     //////////
              //     ///
              //     ///  Navigator
                  
              //     // s = await Navigator.push(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //       builder: (context) => ModifySchedule(selectedDay)
              //     //     )
              //     // );
              //     // // print(scheduleList[selectedDay]?.indexOf(s));
              //     // int? index = scheduleList[selectedDay]?.indexOf(s);
              //     // print(scheduleList[selectedDay]?.elementAt(index).);
        
              //     // setState(() {
                    
              //     // });
              //     // print('title: ${modifySchedule.title}');
              //     // print('$selectedDay : ${scheduleList[selectedDay]?.elementAt(0).title}');

              //     // for(int i = 0; i < scheduleList[selectedDay].forEach((element) {print}); i++)
              //     // scheduleList[selectedDay].forEach((element) {
              //     //   print(element);
              //     // });
              //     // setState(() {
              //     //   scheduleList[selectedDay] = s;
              //     // });
              //   },
              //   child: Container(
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Container(
              //           margin: EdgeInsets.fromLTRB(15 * fem, 0 * fem, 0 * fem, 0 * fem),
              //           width: 115 * fem,
              //           height: 18 * fem,
              //           decoration: BoxDecoration(
              //             border: Border(
              //               right: BorderSide(width: 5 * ffem, color: Colors.black)
              //             )
              //           ),
              //           child: Text(
              //             '${s.startTime} ~ ${s.endTime}',
              //             style: TextStyle(
              //               fontSize: 13 * ffem,
              //               fontWeight: FontWeight.w400,
              //               height: 1.2125 * ffem / fem,
              //               color: Color(0xff000000),
              //             ),
              //           )
              //         ),
              //         Container(
              //           margin: EdgeInsets.fromLTRB(10 * fem, 0 * fem, 0 * fem, 0 * fem),
              //           width: 180 * fem,
              //           height: 18 * fem,
              //           child: Text(
              //             '${s.title}',
              //             style: TextStyle(
              //               fontSize: 13 * ffem,
              //               fontWeight: FontWeight.w400,
              //               height: 1.2125 * ffem / fem,
              //               color: Color(0xff000000),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              //  ),
            title: InkWell(
              onTap: () async {
                  final modifySchedule = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ModifyScheduleForm(selectedDay)
                    )
                  );
              },
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(15 * fem, 0 * fem, 0 * fem, 0 * fem),
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
                      margin: EdgeInsets.fromLTRB(10 * fem, 0 * fem, 0 * fem, 0 * fem),
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
            ),),  
          ),// map

          
          Container(
            margin: EdgeInsets.fromLTRB(0 * fem, 15 * fem, 0 * fem, 10 * fem),
            width: 320 * fem,
            height: 22 * fem,
            child: Text(
              '할 일',
              style: GoogleFonts.lato(
                fontSize: 15 * ffem,
                fontWeight: FontWeight.w700,
                height: 1.5 * ffem / fem,
                color: Color(0xff000000),
              ),
              textAlign: TextAlign.left,
            ),
          ),
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
      ),
    );
  }
}