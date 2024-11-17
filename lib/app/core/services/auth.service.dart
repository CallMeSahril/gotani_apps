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

  // login
  Future login(String email, String password) async {
    try {
      final response = await dioCustom.post('login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data['data'];
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print('Error while login: $e');
      return null;
    }
  }
}
