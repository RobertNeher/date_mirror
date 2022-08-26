import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String format() {
    DateFormat df = DateFormat('dd.MM.yyyy');
    return df.format(this);
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return (year == other.year && month == other.month && day == other.day);
  }
}
