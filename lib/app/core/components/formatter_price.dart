import 'package:intl/intl.dart';

class Formatter {
  static String formatToRupiah(int? amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(amount ?? 0);
  }

  // format tanggal menjadi string
  static String formatDate(DateTime date, {String format = 'dd-MM-yyyy'}) {
    return DateFormat(format).format(date);
  }

  // format tanggal dan waktu menjadi string
  static String formatDateTime(DateTime dateTime,
      {String format = 'dd-MM-yyyy HH:mm:ss'}) {
    return DateFormat(format).format(dateTime);
  }

  // parse string menjadi DateTime
  static DateTime parseDate(String dateString, {String format = 'dd-MM-yyyy'}) {
    return DateFormat(format).parse(dateString);
  }
}
