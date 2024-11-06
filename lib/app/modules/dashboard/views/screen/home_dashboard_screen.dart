import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotani_apps/app/core/components/custom_text_field.dart';
import 'package:gotani_apps/app/modules/dashboard/controllers/home_dashboard_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeDashboardScreen extends GetView<HomeDashboardController> {
  const HomeDashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // await controller.refreshData();
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: 27.h,
                decoration: BoxDecoration(
                  color: Color(0xff439A31),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
              Positioned(
                top: 10.h,
                left: 16,
                right: 16,
                child: Text(
                  'Hai sobat Gotani, jelajahi peralatan terbaru sesuai kebutuhan tani anda',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                right: 16,
                left: 16,
                top: 15.5.h,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomTextField(
                    prefixIcon: Icon(Icons.search),
                    isBorder: false,
                    controller: TextEditingController(),
                    label: "Search",
                  ),
                ),
              ),
              Positioned(
                top: 185,
                left: 2,
                right: 2,
                child: SizedBox(
                  height: 15.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.listCategori.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 25.w,
                        color: Colors.pink,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                height: 10.h,
                                color: Colors.amber,
                              ),
                              Text(
                                'Item ${controller.listCategori[index]['name']}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 300,
                left: 2,
                right: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Terpopuler",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.listCategori.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.pink,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    height: 10.h,
                                    color: Colors.amber,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Pupuk Urea',
                                      style: TextStyle(color: Colors.black),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '250.000 - 250.000',
                                      style: TextStyle(color: Colors.black),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
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
              Positioned(
                top: 500,
                left: 2,
                right: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 18.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.listCategori.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.pink,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    height: 10.h,
                                    color: Colors.amber,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Pupuk Urea',
                                      style: TextStyle(color: Colors.black),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '250.000 - 250.000',
                                      style: TextStyle(color: Colors.black),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
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
            ],
          ),
        ),
      ),
    );
  }
}
