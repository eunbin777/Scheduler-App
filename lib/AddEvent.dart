import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:term_project/AddEvent.dart';
import 'package:term_project/AppDrawer.dart';
import 'package:term_project/Calendar.dart';
import 'package:term_project/Schedule.dart';
import 'package:intl/intl.dart';


class AddEvent extends StatefulWidget {
  // final Schedule schedule;
  final DateTime selectedDay;

  AddEvent(@required this.selectedDay, {Key? key}) : super(key : key);
  // AddEvent({Key: key, this.schedule}) : super(key : key);

  _AddEvent createState() => _AddEvent();
}

class _AddEvent extends State<AddEvent> {
  String? sHour, sMin, eHour, eMin, notificationTime, nHour, nMin;
  String startTime = "00 : 00";
  String endTime = "00 : 00";

  final titleController = TextEditingController();  // title
  final sharingUserController = TextEditingController();  // userEmail

  @override
  void dispose() {
    titleController.dispose();
    sharingUserController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // DateTime selected = widget.schedule.selectedDay;
    String title = titleController.text;
    String? sharingUser = sharingUserController.text;

    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    String weekday = DateFormat('E', 'ko').format(widget.selectedDay);  // weekday
    String today = DateFormat('yyyy년 MM월 dd일 ').format(widget.selectedDay);  // today

    TimeOfDay currentTime = TimeOfDay.now();

    // Schedule schedule = new Schedule(titleController.text,  startTime, endTime, sharedUserController.text, alarm);
    // print('schedule: ${schedule.title}');

    // Schedule schedule = new Schedule.add(titleController.text, selected, startTime, endTime, sharedUserController.text, alarm);

    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Container(
        padding: EdgeInsets.fromLTRB(20 * fem, 20 * fem, 20 * fem, 20 * fem),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0 * fem, 100 * fem, 0 * fem, 23 * fem),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: '제목',
                  hintStyle: GoogleFonts.lato (
                    fontSize: 18 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.2125 * ffem / fem,
                    color: Color(0x7f000000),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0 * fem, 15 * ffem, 44 * fem, 29 * fem),
              width: 260 * fem,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 날짜 / 시간
                  Container(
                    margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 100 * fem, 3 * fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
                          width: 18 * fem,
                          height: 18 * fem,
                          child: Image.asset(
                            "images/date.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(5 * fem, 0 * fem, 0 * fem, 1 * fem),
                          child: Text(
                            '날짜 / 시간',
                            style: GoogleFonts.lato(
                              fontSize: 11 * fem,
                              fontWeight: FontWeight.w500,
                              height: 1.2125 * ffem / fem,
                              color: Color(0xb2000000),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(22 * fem, 15 * fem, 118 * fem, 10 * fem),
                    padding: EdgeInsets.fromLTRB(12 * fem, 5 * fem, 9.94 * fem, 5 * fem),
                    width: 130 * fem,
                    decoration: BoxDecoration (
                      color: Color(0xffd9d9d9),
                      borderRadius: BorderRadius.circular(10 * fem),
                    ),
                    child: Text(
                      '$today $weekday요일',
                      style: GoogleFonts.lato(
                        fontSize: 8 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.2125 * ffem / fem,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(22 * fem, 0 * fem, 0 * fem, 10 * fem),
                    width: 200 * fem,
                    decoration: BoxDecoration (
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10 * fem),
                    ),
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )
                            ),
                            backgroundColor: MaterialStateProperty.all(Color(0xffd9d9d9)),
                          ),
                          child: Text(
                            startTime != null ? '$startTime' : '00 : 00',
                            style: TextStyle(fontSize: 10 * ffem),
                          ),
                          // startTime
                          onPressed: () {
                            Future<TimeOfDay?> selectedTime = showTimePicker(
                              context: context,
                              initialTime: currentTime,
                            );
                            selectedTime.then((timeOfDay) {
                              setState(() {
                                String? hour = timeOfDay?.hour.toString().padLeft(2, "0");
                                String? min = timeOfDay?.minute.toString().padLeft(2, "0");
                                startTime = '$hour : $min';
                              });
                            });
                          },
                        ),
                        Container(
                          width: 30 * fem,
                          child: Text(' ~ ', textAlign: TextAlign.center,),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )
                            ),
                            backgroundColor: MaterialStateProperty.all(Color(0xffd9d9d9)),
                          ),
                          onPressed: () {
                            Future<TimeOfDay?> selectedTime = showTimePicker(
                              context: context,
                              initialTime: currentTime,
                            );
                            selectedTime.then((timeOfDay) {
                              setState(() {
                                String? hour = timeOfDay?.hour.toString().padLeft(2, "0");
                                String? min = timeOfDay?.minute.toString().padLeft(2, "0");
                                eHour = '$hour';
                                eMin = '$min';
                                endTime = '$eHour : $eMin';
                              });
                            });
                          },
                          child: Text(
                            endTime != null ? '$endTime' : '00 : 00',
                            style: TextStyle(fontSize: 10 * ffem),
                          ),
                        )
                      ],
                    )
                  ),
                  // 공유
                  Container(
                    margin: EdgeInsets.fromLTRB(0 * fem, 15 * ffem, 44 * fem, 5 * fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
                          width: 18 * fem,
                          height: 18 * fem,
                          child: Image.asset(
                            "images/user.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(5 * fem, 0 * fem, 0 * fem, 1 * fem),
                          child: Text(
                            '공유',
                            style: GoogleFonts.lato(
                              fontSize: 11 * fem,
                              fontWeight: FontWeight.w500,
                              height: 1.2125 * ffem / fem,
                              color: Color(0xb2000000),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(22 * fem, 0 * fem, 0 * fem, 25 * fem),
                    padding: EdgeInsets.fromLTRB(12 * fem, 5 * fem, 9.94 * fem, 5 * fem),
                    width: 200 * fem,
                    decoration: BoxDecoration (
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10 * fem),
                    ),
                    child: TextField(
                      controller: sharingUserController,
                      decoration: InputDecoration(
                        hintText: '공유할 사용자의 이메일을 입력해주세요.',
                        hintStyle: GoogleFonts.lato(
                          fontSize: 8 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2125 * ffem / fem,
                        ), 
                      ),
                    ),
                  ),
                  // 알림
                  Container(
                    margin: EdgeInsets.fromLTRB(0 * fem, 15 * ffem, 44 * fem, 5 * fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
                          width: 18 * fem,
                          height: 18 * fem,
                          child: Image.asset(
                            "images/bell.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(5 * fem, 0 * fem, 0 * fem, 1 * fem),
                          child: Text(
                            '알림',
                            style: GoogleFonts.lato(
                              fontSize: 11 * fem,
                              fontWeight: FontWeight.w500,
                              height: 1.2125 * ffem / fem,
                              color: Color(0xb2000000),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                  // 알림
                  Container(
                    margin: EdgeInsets.fromLTRB(22 * fem, 0 * fem, 0 * fem, 25 * fem),
                    padding: EdgeInsets.fromLTRB(12 * fem, 5 * fem, 9.94 * fem, 5 * fem),
                    width: 200 * fem,
                    decoration: BoxDecoration (
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10 * fem),
                    ),
                    child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )
                            ),
                            backgroundColor: MaterialStateProperty.all(Color(0xffd9d9d9)),
                          ),
                          child: Text(
                            notificationTime != null ? '$notificationTime' : '00 : 00',
                            style: TextStyle(fontSize: 10 * ffem),
                          ),
                          onPressed: () {
                            Future<TimeOfDay?> selectedTime = showTimePicker(
                              context: context,
                              initialTime: currentTime,
                            );
                            selectedTime.then((timeOfDay) {
                              setState(() {
                                String? hour = timeOfDay?.hour.toString().padLeft(2, "0");
                                String? min = timeOfDay?.minute.toString().padLeft(2, "0");
                                nHour = '$hour';
                                nMin = '$min';
                                notificationTime = '$nHour : $nMin';
                              });
                            });
                          },
                        ),
                  ), 
                ],             
              ),
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => 
          // if(sharingUser != null && alarm != null)
        Navigator.pop(context, Schedule(title, startTime, endTime, sharingUser, notificationTime)),
        label: Text("+"),
      ),
    );
  }
}