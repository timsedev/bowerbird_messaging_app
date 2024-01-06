import 'package:bowerbird_messaging_app/app/app.locator.dart';
import 'package:bowerbird_messaging_app/core/models/message_group.dart';
import 'package:bowerbird_messaging_app/core/models/response/message_group_response.dart';
import 'package:bowerbird_messaging_app/ui/common/path.dart';
import 'package:bowerbird_messaging_app/util/log_exception.dart';
import 'package:dio/dio.dart';

import 'auth_service.dart';

class MessageService {
  final _authService = locator<AuthService>();
  final Dio _dio;

  bool get isLoggedIn => _authService.user != null;
  String? get token => _authService.token;

  MessageService({Dio? dio}) : _dio = dio ?? Dio();

  Future<List<MessageGroup>?> getMessageGroups(bool isLoggedIn) async {
    try {
      if (!isLoggedIn) {
        return null;
      }

      final response = await _dio.get(
        Path.indexMessageGroups,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final messageGroupsResponse =
            MessageGroupResponse.fromJson(response.data);
        return messageGroupsResponse.messageGroups;
      } else {
        return null;
      }
    } catch (e) {
      logException(e);
      return null;
    }
  }
}
