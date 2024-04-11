import 'package:shamsi_date/shamsi_date.dart';
import 'package:intl/intl.dart';

(String, String) converDateAndTime(String value) {
  DateTime dateTime = DateTime.parse(value);
  Jalali jalaliDate = Jalali.fromDateTime(dateTime);
  String hourMinute = DateFormat('HH:mm').format(dateTime);
  return (
    '${jalaliDate.year}/${jalaliDate.month}/${jalaliDate.day}',
    hourMinute
  );
}
