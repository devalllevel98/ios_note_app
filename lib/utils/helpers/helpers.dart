import 'package:intl/intl.dart';

timeFormat(String time) {
  return DateFormat("MMM d,yyyy").format(DateTime.parse(time));
}
