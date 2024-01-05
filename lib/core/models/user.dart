class User {
  final String id;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;

  User({
    required this.id,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final createdAt = DateTime.parse(json['created_at']);
    final updatedAt = DateTime.parse(json['updated_at']);

    return User(
      id: json['id'],
      email: json['email'],
      createdAt: createdAt,
      updatedAt: updatedAt,
      name: json['name'],
    );
  }
}
