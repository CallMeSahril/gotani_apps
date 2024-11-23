import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:gotani_apps/app/core/assets/assets.gen.dart';
import 'package:gotani_apps/app/core/components/buttons.dart';
import 'package:gotani_apps/app/core/components/custom_text_field.dart';
import 'package:gotani_apps/app/core/components/spaces.dart';
import 'package:gotani_apps/app/routes/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: RegisterController(),
        builder: (controller) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(children: [
                  Image.asset(
                    Assets.images.logo.path,
                    width: 20.w,
                    height: 40.h,
                  ),
                  SpaceHeight(10),
                  Text(
                    "Daftarkan Akun Anda",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SpaceHeight(10),
                  CustomTextField(
                    controller: controller.usernameController,
                    label: "Username",
                  ),
                  SpaceHeight(10),
                  CustomTextField(
                    controller: controller.emailController,
                    label: "Email",
                  ),
                  SpaceHeight(10),
                  Obx(() => CustomTextField(
                        controller: controller.passwordController,
                        label: "Password",
                        obscureText: true,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isEyes.value ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            controller.isEyes.value = !controller.isEyes.value;
                          },
                        ),
                      )),
                  SpaceHeight(10),
                  controller.isLoading == true
                      ? Button.filled(
                          color: Colors.grey,
                          onPressed: () {},
                          label: "loading",
                        )
                      : Button.filled(
                          color: Color(0xff00AA13),
                          onPressed: () {
                            controller.register();
                          },
                          label: "Register",
                        ),
                  SpaceHeight(10),
                  Row(
                    children: [
                      Text(
                        "Sudah Memiliki akun ? ",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offAllNamed(Routes.LOGIN);
                        },
                        child: Text(
                          "Masuk",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SpaceHeight(20),
                ]),
              ));
        });
  }
}
