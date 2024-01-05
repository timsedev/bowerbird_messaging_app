import 'package:bowerbird_messaging_app/services/auth_service.dart';
import 'package:bowerbird_messaging_app/ui/common/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bowerbird_messaging_app/app/app.locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helpers.dart';
import 'auth_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group('AuthServiceTest -', () {
    AuthService? authService;
    MockDio? mockDio;

    setUp(() {
      registerServices();
      mockDio = MockDio();
      authService = AuthService(dio: mockDio);
    });

    tearDown(() => locator.reset());

    test('When login is called with valid credentials, returns true', () async {
      when(mockDio!.post(
        any,
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer(
        (_) async => Response(
          data: {
            "jwt_token": "test_token",
            "data": {
              "id": "000000",
              "email": "test@test.com",
              "created_at": "2024-01-03T02:02:18.166Z",
              "updated_at": "2024-01-05T07:13:21.827Z",
              "name": "Test"
            }
          },
          statusCode: 200,
          requestOptions: RequestOptions(
            path: '$baseUrl/login',
          ),
        ),
      );

      final result = await authService!.login('test@test.com', 'password');

      expect(result, true);
    });

    test('When login is called with invalid credentials, returns false',
        () async {
      when(mockDio!.post(
        any,
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer(
        (_) async => Response(
          data: null,
          statusCode: 401,
          requestOptions: RequestOptions(
            path: '$baseUrl/login',
          ),
        ),
      );

      final result = await authService!.login('test@test.com', 'password');

      expect(result, false);
    });
  });
}
