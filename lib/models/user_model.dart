import 'dart:convert';

UserModel userModelFromMap(String str) => UserModel.fromMap(json.decode(str));

class UserModel {
  final String email;
  final String password;
  final String name;
  final String role;
  final String avatar;
  final String id;

  UserModel({
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.avatar,
    required this.id,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        email: json['email'],
        password: json['password'],
        name: json['name'],
        role: json['role'],
        avatar: json['avatar'],
        id: json['id'].toString(),
      );
}
