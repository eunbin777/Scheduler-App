import 'package:flutter/foundation.dart';

// class Schedule {
//   final String title;
//   DateTime? startTime = null;
//   DateTime? endTime = null;
//   String? sharingUser = null;
//   DateTime? notificationTime = null;

//   Schedule({required this.title, this.startTime, this.endTime, this.sharingUser,
//       this.notificationTime});

//   String toString() => this.title;
// }

class Schedule {
  String title;
  // DateTime selectedDay;
  String startTime;
  String endTime;
  String? sharingUser;
  String? notificationTime;

  // Schedule(this.title);
  // Schedule(this.title, this.startTime, this.endTime);
  // Schedule.addUser(this.title, this.startTime, this.endTime, this.sharingUser);
  // Schedule.addAlarm(this.title, this.startTime, this.endTime, this.notificationTime);
  Schedule(this.title, this.startTime, this.endTime, this.sharingUser, this.notificationTime);
}