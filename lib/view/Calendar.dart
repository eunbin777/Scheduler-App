import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  DateTime focusedDay = DateTime.now();

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().weekday,
  ); 

  CalendarFormat calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;

    return Center(
      child: Container(
        width: 0.9 * width,
        padding: EdgeInsets.only(bottom: 0.01 * height),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.0
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: TableCalendar(
          locale: 'ko_KR',
          focusedDay: focusedDay,
          firstDay: DateTime(1990, 1, 1),
          lastDay: DateTime(2030, 12, 31),
          calendarFormat: calendarFormat,
          availableCalendarFormats: const {
            CalendarFormat.month: '월  ▼',
            CalendarFormat.twoWeeks: '2주  ▼',
            CalendarFormat.week: '1주  ▼',
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
          calendarBuilders: CalendarBuilders(
            dowBuilder: (context, day) {
              if (day.weekday == DateTime.sunday) {
                return const Center(
                  child: Text(
                    '일',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                );
              }
            },
          ),
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
              fontWeight: FontWeight.bold,
            ),
            todayDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffe8e8e8),
            ),
            selectedTextStyle: TextStyle(
              color: Colors.black,
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
    );
  }
}