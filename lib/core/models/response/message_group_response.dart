import 'package:bowerbird_messaging_app/core/models/message_group.dart';

class MessageGroupResponse {
  final List<MessageGroup> messageGroups;

  MessageGroupResponse({required this.messageGroups});

  factory MessageGroupResponse.fromJson(List<dynamic> json) {
    return MessageGroupResponse(
      messageGroups: json.map((item) => MessageGroup.fromJson(item)).toList(),
    );
  }
}
