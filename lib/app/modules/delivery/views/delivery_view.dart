import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/components/validation_pop_up.dart';
import '../controllers/delivery_controller.dart';

class DeliveryView extends GetView<DeliveryController> {
  const DeliveryView({super.key});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                      "Pilih Opsi Pengiriman",
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
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.listCourier.length,
                itemBuilder: (context, index) {
                  var courier = controller.listCourier[index];
                  return InkWell(
                    onTap: () {
                      controller.courier.value = courier;
                      controller.fetchDeliveryType();
                    },
                    child: Container(
                      width: width,
                      padding: EdgeInsets.all(width * 0.03),
                      margin: EdgeInsets.only(
                        bottom: width * 0.05,
                        left: width * 0.05,
                        right: width * 0.05,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(width * 0.05),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            courier,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: width * 0.04,
              ),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.listDelivery.length,
                  itemBuilder: (context, index) {
                    var courier = controller.listDelivery[index];
                    return InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return ValidationPopUp(
                              title: "Konfirmasi",
                              pesan:
                                  "Apakah Anda yakin memilih alamat ${courier.service}-${courier.description}- Rp. ${courier.cost![0].value}?",
                              buttonLabel: "Lanjutkan",
                              onPressed: () {
                                Get.back();
                                Get.back(result: courier);
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        width: width,
                        padding: EdgeInsets.all(width * 0.03),
                        margin: EdgeInsets.only(
                          bottom: width * 0.05,
                          left: width * 0.05,
                          right: width * 0.05,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(width * 0.05),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(4, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              courier.service ?? "-",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: width * 0.02,
                            ),
                            Text(
                              courier.description ?? "-",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: width * 0.02,
                            ),
                            Text(
                              "Rp. ${courier.cost![0].value}",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
