import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gotani_apps/app/core/helper/shared_preferences_helper.dart';
import 'package:gotani_apps/main.dart';
// import 'package:http/http.dart' as http;

class RepositorityEdit {
  Future<bool> editPhotoProfile(String filePath) async {
    final token = await TokenManager().getToken();
    FormData formData = FormData.fromMap({
      "store_logo":
          await MultipartFile.fromFile(filePath, filename: 'image.jpg'),
    });
    var dio = Dio();
    var response = await dio.post('$mainUrl/profile/store-logo',
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
        data: formData);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
