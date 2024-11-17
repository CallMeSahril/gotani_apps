import 'package:get/get.dart';

class CategoryListController extends GetxController {
  final List<Map<String, dynamic>> categories = [
    {
      'image': 'https://placehold.co/1920x1080',
      'name': 'Bibit',
      'description': 'Stok Bibit Hampir Habis Segera Input Ulang!',
      'stock': 10,
      'warning': true,
    },
    {
      'image': 'https://placehold.co/1920x1080',
      'name': 'Pupuk',
      'description': 'Stok Pupuk Melimpah',
      'stock': 10,
      'warning': false,
    },
    {
      'image': 'https://placehold.co/1920x1080',
      'name': 'Racun',
      'description': 'Stok Bibit Hampir Habis Segera Input Ulang!',
      'stock': 10,
      'warning': true,
    },
    {
      'image': 'https://placehold.co/1920x1080',
      'name': 'Alat Tani',
      'description': 'Stok Alat Tani Melimpah',
      'stock': 10,
      'warning': false,
    },
  ];
}
