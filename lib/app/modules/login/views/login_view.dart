import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotani_apps/app/core/components/buttons.dart';
import 'package:gotani_apps/app/core/components/custom_text_field.dart';
import 'package:gotani_apps/app/core/components/spaces.dart';
import 'package:gotani_apps/app/modules/login/controllers/login_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
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
            controller: controller.emailController,
            // controller: _controllerEmail,
            label: "Username",
          ),
          SpaceHeight(10),
          Obx(() => CustomTextField(
                controller: controller.passwordController,
                // controller: _controllerPass,
                label: "Password",
                obscureText: controller.isEyes.value,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isEyes.value ? Icons.visibility : Icons.visibility_off,
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
          Obx(
            () => controller.isLoading.value == true
                ? Button.filled(
                    color: Colors.grey,
                    onPressed: () {},
                    label: "loading",
                  )
                : Button.filled(
                    color: Color(0xff5A64EA),
                    onPressed: () {
                      controller.login();
                    },
                    label: "Login",
                  ),
          ),
        ],
      ),
    ));
  }
}
