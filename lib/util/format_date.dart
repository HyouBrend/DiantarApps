import 'package:intl/intl.dart';

String formatDate(String dateStr) {
  // Definisikan format input dari string tanggal
  DateFormat inputFormat = DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz', 'en_US');

  // Parsing string tanggal
  DateTime dateTime = inputFormat.parse(dateStr);

  // Formatting tanggal dan waktu dalam format bahasa Indonesia
  DateFormat outputFormat = DateFormat('EEEE, d MMMM yyyy HH:mm', 'id_ID');
  String formattedDate = outputFormat.format(dateTime);

  return '$formattedDate WIB';
}
