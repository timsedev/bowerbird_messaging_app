import 'package:bowerbird_messaging_app/core/models/response/user_response.dart';
import 'package:bowerbird_messaging_app/core/models/user.dart';
import 'package:bowerbird_messaging_app/util/log_exception.dart';
import 'package:dio/dio.dart';

import '../ui/common/constants.dart';

class AuthService {
  final Dio _dio = Dio();

  /// Temporary variable to store token here
  /// TODO: Store token in flutter_secure_storage
  String? token;

  /// The currently logged in user
  User? user;

  Future<bool> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '$baseUrl/login',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(contentType: Headers.jsonContentType),
      );

      if (response.statusCode == 200) {
        final userResponse = UserResponse.fromJson(response.data);
        token = userResponse.token;
        user = userResponse.user;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      logException(e);
      return false;
    }
  }
}
