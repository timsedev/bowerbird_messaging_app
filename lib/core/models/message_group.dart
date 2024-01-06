class MessageGroup {
  final String id;
  final String name;
  final String userId;
  final DateTime? lastMessageAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  MessageGroup({
    required this.id,
    required this.name,
    required this.userId,
    required this.lastMessageAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessageGroup.fromJson(Map<String, dynamic> json) {
    final String? lastMessageAt = json['last_message_at'];

    return MessageGroup(
      id: json['id'],
      name: json['name'],
      userId: json['user_id'],
      lastMessageAt:
          lastMessageAt != null ? DateTime.parse(lastMessageAt) : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
