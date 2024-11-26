import 'package:intl/intl.dart';

String formatCurrency(int amount) {
  final NumberFormat Formatter = NumberFormat.decimalPattern('id');
  return Formatter.format(amount);
}
