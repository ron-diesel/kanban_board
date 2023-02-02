import 'package:intl/intl.dart';

extension DateTimeParse on DateTime {
  String format(String pattern) {
    final dateFormat = DateFormat(pattern);
    return dateFormat.format(this);
  }
}

extension StringExt on String {
  DateTime toDate() {
    return DateTime.parse(this);
  }
}
