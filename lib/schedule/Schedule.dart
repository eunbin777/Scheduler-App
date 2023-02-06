import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';

class Schedule {
  // int id;
  String title;
  String startTime;
  String endTime;
  String? sharingUser;
  String? notificationTime;

  Schedule(this.title, this.startTime, this.endTime, this.sharingUser, this.notificationTime);
}