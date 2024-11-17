import 'package:gotani_apps/app/core/services/dio.h.dart';

class AuthService {
  Future getProfile() async {
    try {
      final response = await dioCustom.get('profile');

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data['data'];
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print('Error while fetching profile: $e');
      return null;
    }
  }
}
