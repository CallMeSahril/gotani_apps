import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CategoryFormController extends GetxController {
  final nameController = TextEditingController();
  final stockController = TextEditingController();
  RxString selectedImage = 'Choose File'.obs;

  void saveCategory() {
    print(
        'Saving category: ${nameController.text}, Stock: ${stockController.text}, Image: $selectedImage');
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = pickedFile.path;
    } else {
      print('No image selected.');
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    stockController.dispose();
    super.onClose();
  }
}
