import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginUser {
  int userId;
  String email;
  String token;
  String role;
  LoginUser({
    required this.userId,
    required this.email,
    required this.token,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'email': email,
      'token': token,
      'role': role,
    };
  }

  factory LoginUser.fromMap(Map<String, dynamic> map) {
    return LoginUser(
      userId: map['userId'] as int,
      email: map['email'] as String,
      token: map['token'] as String,
      role: map['role'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginUser.fromJson(String source) =>
      LoginUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
