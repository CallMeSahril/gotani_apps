import 'package:intl/intl.dart';

String formatCurrency(int amount) {
  final NumberFormat currencyFormatter = NumberFormat.decimalPattern('id');
  return currencyFormatter.format(amount);
}
