import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthlyView extends StatefulWidget {
  const MonthlyView({super.key});

  @override
  MonthlyViewState createState() => MonthlyViewState();
}

class MonthlyViewState extends State<MonthlyView> {
  DateTime focusedDay = DateTime.now();

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().weekday,
  ); 

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;

    return Center(
      child: Container(
        width: 0.9 * width,
        height: 0.45 * height,
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
              if (day.weekday == 7) {
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
            formatButtonVisible: false,
            titleCentered: true,
          ),
          calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            todayTextStyle: const TextStyle(
              color: Colors.black,
            ),
            todayDecoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 1.5,
              )
            ),
          ),
        ),
      ),
    );
  }
}
