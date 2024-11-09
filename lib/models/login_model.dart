import 'dart:convert';

LoginModel loginModelFromMap(String str) =>
    LoginModel.fromMap(json.decode(str));

class LoginModel {
  final String accessToken;
  final String refreshToken;

  LoginModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
        accessToken: json['access_token'],
        refreshToken: json['refresh_token'],
      );
}
