import 'package:bowerbird_messaging_app/core/models/user.dart';

class UserResponse {
  final String token;
  final User user;

  UserResponse({required this.token, required this.user});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      token: json['jwt_token'],
      user: User.fromJson(json['data']),
    );
  }
}
