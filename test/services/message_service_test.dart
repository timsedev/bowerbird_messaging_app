import 'package:bowerbird_messaging_app/core/models/message_group.dart';
import 'package:bowerbird_messaging_app/services/message_service.dart';
import 'package:bowerbird_messaging_app/ui/common/path.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bowerbird_messaging_app/app/app.locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helpers.dart';
import 'message_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group('MessageServiceTest -', () {
    MessageService? messageService;
    MockDio? mockDio;

    setUp(() {
      registerServices();
      mockDio = MockDio();
      messageService = MessageService(dio: mockDio);
    });
    tearDown(() => locator.reset());

    group('getMessageGroups -', () {
      final successfulResponse = [
        {
          "id": "000000",
          "name": "Test",
          "user_id": "000000",
          "last_message_at": "2024-01-05T07:13:21.827Z",
          "created_at": "2024-01-03T02:02:18.166Z",
          "updated_at": "2024-01-05T07:13:21.827Z"
        }
      ];

      test('returns null when user is not logged in', () async {
        expect(await messageService!.getMessageGroups(false), isNull);
      });

      test('returns list of MessageGroup on successful API call', () async {
        when(
          mockDio!.get(
            any,
            options: anyNamed('options'),
          ),
        ).thenAnswer(
          (_) async => Response(
            data: successfulResponse,
            statusCode: 200,
            requestOptions: RequestOptions(
              path: Path.indexMessageGroups,
            ),
          ),
        );

        expect(await messageService!.getMessageGroups(true),
            isA<List<MessageGroup>>());
      });

      test('returns null on unsuccessful API call', () async {
        when(
          mockDio!.get(
            any,
            options: anyNamed('options'),
          ),
        ).thenAnswer(
          (_) async => Response(
            data: null,
            statusCode: 400,
            requestOptions: RequestOptions(
              path: Path.indexMessageGroups,
            ),
          ),
        );

        expect(await messageService!.getMessageGroups(true), isNull);
      });
    });
  });
}
