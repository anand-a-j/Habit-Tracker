import 'package:intl/intl.dart' show DateFormat;

class DateHelper {
    /// Returns a record with nicely formatted parts for rich text:
  /// (day: "19", month: "Oct", year: "2025")
  static ({String day, String month, String year}) formatDateParts(
      DateTime date) {
    final day = DateFormat('d').format(date);
    final month = DateFormat('MMM').format(date);
    final year = DateFormat('y').format(date);

    return (day: day, month: month, year: year);
  }

  /// Returns the full formatted date as a single string, e.g. "19 Oct 2025"
  static String formatDate(DateTime date) {
    return DateFormat('d MMM y').format(date);
  }
}