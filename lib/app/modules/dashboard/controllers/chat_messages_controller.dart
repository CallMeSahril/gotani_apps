import 'package:get/get.dart';

class ChatMessagesController extends GetxController {
  var messages = <Map<String, String>>[].obs;

  void sendMessage(String message) {
    messages.add(
      {
        'sender': 'user',
        'message': message,
      },
    );

    messages.add(
      {
        'sender': 'bot',
        'message': 'ya masih',
      },
    );
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
}
