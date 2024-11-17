import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotani_apps/app/core/components/buttons.dart';
import 'package:gotani_apps/app/core/components/custom_text_field.dart';
import 'package:gotani_apps/app/core/components/spaces.dart';
import 'package:gotani_apps/app/routes/app_pages.dart';
import 'package:gotani_apps/main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Row(
            children: [
              const Icon(Icons.arrow_back_ios),
              const Text('Back'),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            "Silahkan Masukan Akun Anda",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20.sp,
            ),
          ),
          SpaceHeight(10),
          CustomTextField(
            controller: _controllerEmail,
            label: "Username",
          ),
          SpaceHeight(10),
          Obx(() => CustomTextField(
                controller: _controllerPass,
                label: "Password",
                obscureText: true,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isEyes.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    controller.isEyes.value = !controller.isEyes.value;
                  },
                ),
              )),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Add your forgot password logic here
              },
              child: Text(
                "Forgot your password?",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
          Button.filled(
            color: Color(0xff5A64EA),
            onPressed: () async {
              if (_controllerEmail.text == "" || _controllerPass.text == "") {
                Get.snackbar("Warning", "Mohon Isi Seluruh Kolom Yang Ada.");
                return;
              }
              final response = await http.post(
                Uri.parse("$mainUrl/login"),
                body: {
                  "email": _controllerEmail.text,
                  "password": _controllerPass.text
                },
              );
              debugPrint(response.statusCode.toString());
              var body = jsonDecode(response.body);
              switch (response.statusCode) {
                case 401:
                  debugPrint("failed login");
                  Get.snackbar("Warning", "Wrong Email or Password");
                  break;
                case 200:
                  if (body["status"] == "success") {
                    var pref = await SharedPreferences.getInstance();
                    pref.setString("token", body["data"]["token"]);
                    pref.setBool("login", true);
                    Get.snackbar("Info", "Success Login");
                    Get.offAllNamed(Routes.DASHBOARD);
                  } else {
                    Get.snackbar("Info", "Failed Login");
                  }

                  break;
              }
            },
            label: "Login",
          ),
        ],
      ),
    ));
  }
}
