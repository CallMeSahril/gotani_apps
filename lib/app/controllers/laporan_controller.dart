import 'package:get/get.dart';
import 'package:gotani_apps/app/data/repo/laporan/laporan_repo.dart';

class LaporanController extends GetxController {
  //TODO: Implement LaporanController

  final count = 0.obs;
  Future<GetAnaliticsCatagory> getAnaliticsCatagory() async {
    final response = await LaporanRepo().getAnaliticsCatagory();
    return response;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
