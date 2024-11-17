import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final dioCustom = Dio(
  BaseOptions(
    headers: {
      'Authorization': 'Bearer ${dotenv.env['DEV_TOKEN_ADMIN'] ?? ''}',
    },
    contentType: Headers.jsonContentType,
    baseUrl: dotenv.env['API_URL'] ?? '',
  ),
);
