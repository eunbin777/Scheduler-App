import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:Scheduler/todo/Todo.dart';

class ModifyTodoForm extends StatefulWidget {
  final DateTime selectedDay;

  const ModifyTodoForm(this.selectedDay, {Key? key}) : super(key : key);

  ModifyTodoFormState createState() => ModifyTodoFormState();
}

class ModifyTodoFormState extends State<ModifyTodoForm> {
  final taskController = TextEditingController();
  final sharingUserController = TextEditingController();

  String? weekday;
  String? today;

  String? notificationTime, nHour, nMin;

  TimeOfDay currentTime = TimeOfDay.now();

  @override
  void dispose() {
    taskController.dispose();
    sharingUserController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final navigator = Navigator.of(context);

    DateTime selectedDay = widget.selectedDay;
    String task = taskController.text;

    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Container(
          width: 0.8 * width,
          margin: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  bottom: 50.0
                ),
                child: TextField(
                  controller: taskController,
                  decoration: InputDecoration(
                    hintText: '제목',
                    hintStyle: GoogleFonts.lato(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 50.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          child: const Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                            size: 25.0,
                          ),
                        ),
                        const Text(
                          '날짜',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 25.0,
                          margin: const EdgeInsets.fromLTRB(35.0, 10.0, 0.0, 5.0),
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                )
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                const Color(0xffd9d9d9)
                              ),
                            ),
                            child: Text(
                              (today == null)?
                              '${DateFormat('yyyy년 MM월 dd일').format(widget.selectedDay).toString()} ${DateFormat('E', 'ko').format(widget.selectedDay)}요일'
                              : '$today $weekday요일',
                              style: GoogleFonts.lato(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () {
                              Future<DateTime?> selectedDay = showDatePicker(
                                context: context,
                                initialDate: widget.selectedDay,
                                firstDate: DateTime(1990),
                                lastDate: DateTime(2030),
                              );
                              selectedDay.then((date) {
                                setState(() {
                                  today = DateFormat('yyyy년 MM월 dd일').format(date!).toString();
                                  weekday = DateFormat('E', 'ko').format(date);
                                });
                              });
                            },
                          ),
                        ),
                      ]
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          child: const Icon(
                            Icons.alarm,
                            color: Colors.black,
                            size: 25.0,
                          ),
                        ),
                        const Text(
                          '알림',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 35.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                )
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                const Color(0xffd9d9d9)
                              ),
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
                            child: Text(
                              notificationTime == null ? '00 : 00' : '$notificationTime',
                              style: GoogleFonts.lato(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  navigator.pop(
                    Todo("null", false)
                  );
                },
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10.0),
                      child: const Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.black,
                        size: 25.0,
                      ),
                    ),
                    const Text(
                      '삭제',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => navigator.pop(
            Todo(task, false)
        ),
        backgroundColor: Colors.black,
        label: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }
}