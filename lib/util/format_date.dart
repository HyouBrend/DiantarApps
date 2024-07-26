import 'package:intl/intl.dart';

String? formatDisplayDate(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) {
    return null;
  }

  try {
    DateFormat inputFormat =
        DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz', 'en_US');
    DateTime dateTime = inputFormat.parse(dateStr);

    DateFormat outputFormat = DateFormat('EEEE, dd MMMM yyyy HH:mm', 'id_ID');
    return outputFormat.format(dateTime) + ' WIB';
  } catch (e) {
    return null;
  }
}

String? formatBackendDate(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) {
    return null;
  }

  try {
    DateFormat inputFormat =
        DateFormat('EEEE, dd MMMM yyyy HH:mm WIB', 'id_ID');
    DateTime dateTime = inputFormat.parse(dateStr);

    DateFormat outputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss', 'en_US');
    return outputFormat.format(dateTime);
  } catch (e) {
    return null;
  }
}
