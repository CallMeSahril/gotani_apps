import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/chat_messages_controller.dart';

class ChatMessagesScreen extends GetView<ChatMessagesController> {
  ChatMessagesScreen({super.key});
  @override
  final controller = Get.put(ChatMessagesController());
  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFEFF5EC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF5EC),
        elevation: 0,
        title: const Text(
          'Pesan',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  final isUser = message['sender'] == 'user';

                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 4.0,
                        bottom: 4.0,
                        left: isUser ? 50.0 : 10.0,
                        right: isUser ? 10.0 : 50.0,
                      ),
                      padding: EdgeInsets.fromLTRB(
                        isUser ? 12.0 : 18.0,
                        12.0,
                        isUser ? 14.0 : 12.0,
                        12.0,
                      ),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.grey[300] : Colors.grey[400],
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(12.0),
                          topRight: const Radius.circular(12.0),
                          bottomLeft: isUser ? const Radius.circular(12.0) : Radius.zero,
                          bottomRight: isUser ? Radius.zero : const Radius.circular(12.0),
                        ),
                      ),
                      child: Text(
                        message['message'] ?? '',
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Tulis Pesan...',
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.green),
                  onPressed: () {
                    if (messageController.text.trim().isNotEmpty) {
                      controller.sendMessage(messageController.text.trim());

                      messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
