import 'package:get/get.dart';
import 'package:gotani_apps/app/data/repo/transaksi/transaksi_repo.dart';

class TransaksiController extends GetxController {
  var isLoading = false;
  var dataTransaksi = <DataTransaksi>[];
  var selectedFilter = 'Semua';
  var filterList = ['Semua', 'Harian', 'Mingguan', 'Bulanan'];

  void updateSelectedFilter(String filter) {
    selectedFilter = filter;
    update();
  }

  void filterHistory(String filter) async {
    isLoading = true;
    update();
    await getHistory();
    if (filter != 'Semua') {
      dataTransaksi = applyDateFilter(dataTransaksi, filter);
    }
    isLoading = false;
    update();
  }

  List<DataTransaksi> applyDateFilter(List<DataTransaksi> data, String filter) {
    final now = DateTime.now();
    if (filter == 'Harian') {
      return data.where((transaksi) {
        final date = transaksi.createdAt!;
        return date.toLocal().year == now.year &&
            date.toLocal().month == now.month &&
            date.toLocal().day == now.day;
      }).toList();
    } else if (filter == 'Mingguan') {
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      final endOfWeek = startOfWeek.add(Duration(days: 6));
      return data.where((transaksi) {
        final date = transaksi.createdAt!;
        return date
                .toLocal()
                .isAfter(startOfWeek.subtract(Duration(days: 1))) &&
            date.toLocal().isBefore(endOfWeek.add(Duration(days: 1)));
      }).toList();
    } else if (filter == 'Bulanan') {
      return data.where((transaksi) {
        final date = transaksi.createdAt!;
        return date.toLocal().year == now.year &&
            date.toLocal().month == now.month &&
            date.toLocal().day <= DateTime(now.year, now.month + 1, 0).day;
      }).toList();
    }
    return data;
  }

  void clearFilter() {
    selectedFilter = 'Semua';
    getHistory();
  }

  Future<void> getHistory() async {
    isLoading = true;
    update();
    final response = await TransaksiRepo().getHistory();
    dataTransaksi = response ?? [];
    isLoading = false;
    update();
  }
}
