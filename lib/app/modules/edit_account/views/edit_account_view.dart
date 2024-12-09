import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/components/custom_text_field.dart';
import '../../dashboard/model/model_kabupaten.dart';
import '../../dashboard/model/model_province.dart';
import '../controllers/edit_account_controller.dart';

class EditAccountView extends GetView<EditAccountController> {
  const EditAccountView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Akun'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(onTap: () async {
                final pickedFile = await controller.pickImage();
                if (pickedFile != null) {
                  controller.updateStoreLogo(pickedFile);
                }
              }, child: Obx(() {
                return controller.isImage.value == null
                    ? controller.dataProfile.value.storeLogo != null
                        ? Center(
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      controller.dataProfile.value.storeLogo!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.grey,
                              ),
                              child:
                                  Icon(Icons.camera_alt, color: Colors.white),
                            ),
                          )
                    : Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              image: FileImage(controller.isImage.value!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
              })),
              Text("Nama"),
              CustomTextField(
                controller: controller.controllerName,
                label: "Nama",
              ),
              SizedBox(height: 16),
              Text("Nama Toko"),
              CustomTextField(
                controller: controller.controllerStoreName,
                label: "Nama Toko",
              ),
              SizedBox(height: 16),
              Text("Alamat"),
              CustomTextField(
                controller: controller.controllerAddress,
                label: "Alamat",
              ),
              SizedBox(height: 16),
              Text("Provinsi"),
              DropdownSearch<ModelProvince>(
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                ),
                selectedItem: controller.province.value.province == null
                    ? ModelProvince(province: "Pilih Provinsi")
                    : controller.province.value,
                items: controller.listProvinsi,
                itemAsString: (item) => item.province!,
                onChanged: (item) {
                  controller.province.value = item!;
                  controller.fetchKabupaten(item.provinceId!);
                },
                dropdownDecoratorProps: DropDownDecoratorProps(
                  baseStyle: TextStyle(fontSize: 16),
                  dropdownSearchDecoration: InputDecoration(
                    hintText: "Pilih Provinsi",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text("Kabupaten"),
              DropdownSearch<ModelKabupaten>(
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                ),
                selectedItem: controller.kabupaten.value.cityName == null
                    ? ModelKabupaten(cityName: "Pilih Kabupaten")
                    : controller.kabupaten.value,
                items: controller.listKabupaten,
                itemAsString: (item) => item.cityName!,
                onChanged: (item) {
                  controller.kabupaten.value = item!;
                },
                dropdownDecoratorProps: DropDownDecoratorProps(
                  baseStyle: TextStyle(fontSize: 16),
                  dropdownSearchDecoration: InputDecoration(
                    hintText: "Pilih Kabupaten",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xff0E803C),
                  ),
                  onPressed: controller.updateProfile,
                  child: Text("Simpan"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
