// To parse this JSON data, do
//
//     final authRequest = authRequestFromJson(jsonString);

import 'dart:convert';

AuthRequest authRequestFromJson(String str) => AuthRequest.fromJson(json.decode(str));

String authRequestToJson(AuthRequest data) => json.encode(data.toJson());

class AuthRequest {
  AuthRequest({
    this.email,
    this.password,
  });

  String email;
  String password;

  factory AuthRequest.fromJson(Map<String, dynamic> json) => AuthRequest(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}