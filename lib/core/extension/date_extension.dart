import 'package:habitroot/core/enum/weekday.dart';

extension DateTimeWeekdayX on DateTime {
  Weekday get toWeekday {
    switch (weekday) {
      case DateTime.monday:
        return Weekday.mon;
      case DateTime.tuesday:
        return Weekday.tue;
      case DateTime.wednesday:
        return Weekday.wed;
      case DateTime.thursday:
        return Weekday.thu;
      case DateTime.friday:
        return Weekday.fri;
      case DateTime.saturday:
        return Weekday.sat;
      case DateTime.sunday:
      default:
        return Weekday.sun;
    }
  }
}
