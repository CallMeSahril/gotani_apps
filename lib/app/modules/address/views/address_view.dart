import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/validation_pop_up.dart';
import '../../../core/helper/shared_preferences_helper.dart';
import '../../dashboard/model/model_kabupaten.dart';
import '../../dashboard/model/model_province.dart';
import '../controllers/address_controller.dart';

class AddressView extends GetView<AddressController> {
  AddressView({super.key});
  final TextEditingController controllerAddress = TextEditingController();
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width,
                padding: EdgeInsets.all(width * 0.03),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.navigate_before_rounded,
                        size: width * 0.1,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    Text(
                      "Pilih Alamat Pengiriman",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: width * 0.04,
              ),
              InkWell(
                onTap: () {
                  controllerName.text = "";
                  controllerPhone.text = "";
                  controllerAddress.text = "";
                  controller.provinsi.value = ModelProvince();
                  controller.kabupaten.value = ModelKabupaten();
                  _showPersistentBottomSheet(context, null);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff0E803C),
                      borderRadius: BorderRadius.circular(width * 0.03)),
                  padding: EdgeInsets.all(width * 0.03),
                  child: Expanded(
                    child: Text(
                      "Add Address",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.listAddress.length,
                  itemBuilder: (context, index) {
                    var address = controller.listAddress[index];
                    return InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return ValidationPopUp(
                              title: "Konfirmasi",
                              pesan:
                                  "Apakah Anda yakin memilih alamat ${address.address}-${address.city}-${address.province}?",
                              buttonLabel: "Lanjutkan",
                              onPressed: () {
                                Get.back();
                                Get.back(result: address);
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        width: width,
                        padding: EdgeInsets.all(width * 0.03),
                        margin: EdgeInsets.all(width * 0.05),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(width * 0.05),
                        ),
                        child: ListTile(
                          title: Text(
                            "Nama: ${address.name}\nNo.Telp: ${address.phone}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "${address.address}/${address.city}/${address.province}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  controllerName.text = address.name ?? "-";
                                  controllerPhone.text = address.phone ?? "-";
                                  controllerAddress.text =
                                      address.address ?? "-";
                                  controller.provinsi.value = ModelProvince(
                                    provinceId: address.provinceId,
                                    province: address.province,
                                  );
                                  controller.kabupaten.value = ModelKabupaten(
                                    cityId: address.cityId,
                                    cityName: address.city,
                                  );
                                  _showPersistentBottomSheet(
                                      context, address.id.toString());
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  final token = await TokenManager().getToken();
                                  final response = await http.delete(
                                    Uri.parse(
                                        "$mainUrl/addresses/${address.id}"),
                                    headers: {
                                      HttpHeaders.authorizationHeader:
                                          "Bearer $token",
                                    },
                                  );
                                  debugPrint(response.statusCode.toString());
                                  debugPrint(response.body);
                                  var body = jsonDecode(response.body);

                                  if (body['status'] == "success") {
                                    Get.snackbar(
                                        "Info", "Success delete address");
                                    controller.fetchAddress();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showPersistentBottomSheet(BuildContext context, String? id) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    id == null ? "Tambah Alamat" : "Edit Alamat",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              CustomTextField(
                controller: controllerName,
                label: "Nama",
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: controllerPhone,
                label: "No. Telp",
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: controllerAddress,
                label: "Alamat Lengkap",
              ),
              SizedBox(height: 16),
              DropdownSearch<ModelProvince>(
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                ),
                selectedItem: controller.provinsi.value.province == null
                    ? ModelProvince(province: "Pilih Provinsi")
                    : controller.provinsi.value,
                items: controller.listProvinsi,
                itemAsString: (item) => item.province!,
                onChanged: (item) {
                  controller.provinsi.value = item!;
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xff0E803C),
                ),
                onPressed: () async {
                  if (controllerName.text.isEmpty ||
                      controllerPhone.text.isEmpty ||
                      controllerAddress.text.isEmpty ||
                      controller.provinsi.value.province == null ||
                      controller.kabupaten.value.cityId == null) {
                    Get.snackbar("Warning", "Mohon isi seluruh kolom.");
                    return;
                  }
                  // Proses simpan alamat
                  var provinsi = controller.provinsi.value;
                  var kabupaten = controller.kabupaten.value;
                  final token = await TokenManager().getToken();

                  final response = id == null
                      ? await http.post(
                          Uri.parse("$mainUrl/addresses"),
                          body: {
                            "name": controllerName.text,
                            "phone": controllerPhone.text,
                            "address": controllerAddress.text,
                            "province": provinsi.province,
                            "province_id": provinsi.provinceId,
                            "city": kabupaten.cityName,
                            "city_id": kabupaten.cityId,
                          },
                          headers: {
                            HttpHeaders.authorizationHeader: "Bearer $token",
                          },
                        )
                      : await http.put(
                          Uri.parse("$mainUrl/addresses/$id"),
                          body: {
                            "name": controllerName.text,
                            "phone": controllerPhone.text,
                            "address": controllerAddress.text,
                            "province": provinsi.province,
                            "province_id": provinsi.provinceId,
                            "city": kabupaten.cityName,
                            "city_id": kabupaten.cityId,
                          },
                          headers: {
                            HttpHeaders.authorizationHeader: "Bearer $token",
                          },
                        );
                  var body = jsonDecode(response.body);
                  print(body['status'] == "success");
                  if (body['status'] == "success") {
                    Get.back();
                    Get.snackbar("Info", "Berhasil menyimpan alamat.");
                    controller.fetchAddress();
                  }
                },
                child: Text("Simpan"),
              ),
            ],
          ),
        );
      },
    );
  }
}
