import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gotani_apps/app/core/helper/shared_preferences_helper.dart';

final dioCustom = Dio(
  BaseOptions(
    contentType: Headers.jsonContentType,
    baseUrl: '${dotenv.env['API_URL']}',
  ),
);
Future<void> configureDioWithToken() async {
  TokenManager tokenManager = TokenManager();
  String? token = await tokenManager.getToken();

  // Jika token ada, tambahkan ke headers
  if (token != null && token.isNotEmpty) {
    dioCustom.options.headers['Authorization'] = 'Bearer $token';
  }
}
