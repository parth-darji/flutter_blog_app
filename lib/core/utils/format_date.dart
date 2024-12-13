import 'package:intl/intl.dart';

String formatDateDMMMYYYY({
  required DateTime dateTime,
}) {
  return DateFormat("d MMM, yyyy").format(dateTime);
}
