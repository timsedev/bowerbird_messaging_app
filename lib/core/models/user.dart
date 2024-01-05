class User {
  final String email;
  final String password;

  User({required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['user']['email'],
      password: json['user']['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': {
        'email': email,
        'password': password,
      },
    };
  }
}
