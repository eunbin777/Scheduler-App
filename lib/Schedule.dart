import 'package:flutter/foundation.dart';

class Schedule {
  final String title;
  DateTime? startTime = null;
  DateTime? endTime = null;
  String? sharingUser = null;
  DateTime? notificationTime = null;

  Schedule({required this.title, this.startTime, this.endTime, this.sharingUser,
      this.notificationTime});

  String toString() => this.title;
}