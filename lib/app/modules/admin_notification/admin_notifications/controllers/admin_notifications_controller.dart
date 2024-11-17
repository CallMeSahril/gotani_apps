import 'package:get/get.dart';

class AdminNotificationsController extends GetxController {
  final notifications = <Notification>[
    Notification(date: '03/10/2024', username: 'halim123', status: 'Baru'),
    Notification(date: '03/10/2024', username: 'kia31', status: 'Baru'),
    Notification(date: '02/10/2024', username: 'epd_12', status: 'Diproses'),
    Notification(date: '02/10/2024', username: 'yul123', status: 'Diproses'),
  ];
}

// Model
class Notification {
  final String date;
  final String username;
  final String status;

  Notification({
    required this.date,
    required this.username,
    required this.status,
  });
}
