class Message {
  final String id;
  final String messageGroupId;
  final String messageGroupMemberId;
  final String userId;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userName;

  Message({
    required this.id,
    required this.messageGroupId,
    required this.messageGroupMemberId,
    required this.userId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.userName,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      messageGroupId: json['message_group_id'],
      messageGroupMemberId: json['message_group_member_id'],
      userId: json['user_id'],
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      userName: json['user_name'],
    );
  }
}
