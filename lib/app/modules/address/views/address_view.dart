import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../../../core/components/custom_text_field.dart';
import '../../dashboard/model/model_address.dart';
import '../../dashboard/model/model_kabupaten.dart';
import '../../dashboard/model/model_province.dart';
import '../controllers/address_controller.dart';

class AddressView extends GetView<AddressController> {
  AddressView({super.key});
  final TextEditingController _controllerAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
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
              _showPersistentBottomSheet(context, _controllerAddress);
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
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.listAddress.length,
            itemBuilder: (context, index) {
              print(controller.listAddress.length);
              var address = controller.listAddress[index];
              return Container(
                width: width,
                padding: EdgeInsets.all(width * 0.03),
                margin: EdgeInsets.only(bottom: width * 0.05),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(width * 0.05),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: width * 0.9,
                      child: Text(
                        "${address.address}/${address.city}/${address.province}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          )
        ],
      )),
    );
  }

  void _showPersistentBottomSheet(
      BuildContext context, TextEditingController controllerText) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<ModelProvince> listProvinsi = <ModelProvince>[];

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return SafeArea(
          child: Container(
            width: width,
            alignment: Alignment.topCenter,
            color: Colors.transparent,
            child: Column(
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              width > height ? width * 0.04 : height * 0.04),
                          topRight: Radius.circular(
                              width > height ? width * 0.04 : height * 0.04),
                        ),
                        color: Color(0xffEAF0EB)),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.all(
                              width > height ? width * 0.02 : height * 0.02,
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(
                              width > height ? width * 0.02 : height * 0.02,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CustomTextField(
                                  controller: controllerText,
                                  label: "Alamat lengkap",
                                ),
                                SizedBox(
                                  height: width * 0.04,
                                ),
                                DropdownSearch<ModelProvince>(
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                  ),
                                  // selectedItem: controller.provinsi.value,
                                  items: controller.listProvinsi,
                                  itemAsString: (item) => item.province!,
                                  onChanged: (item) {
                                    controller.provinsi.value = item!;
                                    controller
                                        .fetchKabupaten(item!.provinceId!);
                                  },
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    baseStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: "Pilih Provinsi",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: width * 0.04,
                                ),
                                DropdownSearch<ModelKabupaten>(
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                  ),
                                  // selectedItem: controller.kabupaten.value,
                                  items: controller.listKabupaten,
                                  itemAsString: (item) => item.cityName!,
                                  onChanged: (item) {
                                    controller.kabupaten.value = item!;
                                  },
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    baseStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: "Pilih Provinsi",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: width * 0.1,
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (controllerText.text == "" ||
                                        controller.provinsi.value.province ==
                                            null ||
                                        controller.kabupaten.value.cityId ==
                                            null) {
                                      Get.snackbar("Warning",
                                          "Mohon Isi Seluruh Kolom Yang Ada.");
                                      return;
                                    }
                                    var provinsi = controller.provinsi.value;
                                    var kabupaten = controller.kabupaten.value;
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    final response = await http.post(
                                      Uri.parse("$mainUrl/addresses"),
                                      body: {
                                        "address": controllerText.text,
                                        "province": provinsi.province,
                                        "province_id": provinsi.provinceId,
                                        "city": kabupaten.cityName,
                                        "city_id": kabupaten.cityId,
                                      },
                                      headers: {
                                        HttpHeaders.authorizationHeader:
                                            "Bearer ${prefs.getString("token")}",
                                      },
                                    );
                                    debugPrint(response.statusCode.toString());
                                    var body = jsonDecode(response.body);

                                    if (response.statusCode == 200) {
                                      Get.back();
                                      Get.snackbar(
                                          "Info", "Success add address");
                                      controller.fetchAddress();
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xff0E803C),
                                        borderRadius: BorderRadius.circular(
                                            width * 0.03)),
                                    padding: EdgeInsets.all(width * 0.03),
                                    child: Expanded(
                                      child: Text(
                                        "Simpan",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
