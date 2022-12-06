import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// event (schedule)
class Event {
  String title;

  Event(this.title);
}

class Calendar extends StatefulWidget {
  _Calendar createState() => _Calendar();
}

class _Calendar extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month;

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  // add schedule
  Map<DateTime, List<Event>> events = {
    DateTime.utc(2022,12,13) : [ Event('title'), Event('title2') ],
    DateTime.utc(2022,12,14) : [ Event('title3') ],
  };

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
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
        // 선택된 날짜의 상태를 갱신합니다.	
        setState((){
          this.selectedDay = selectedDay;
          this.focusedDay = focusedDay;
        });
      },
      selectedDayPredicate: (DateTime day) {
        // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.	
        return isSameDay(selectedDay, day);
      },
      calendarFormat: format,
      onFormatChanged: (CalendarFormat format) {
        setState(() {
          this.format = format;
        });
      },
    );
  }
}