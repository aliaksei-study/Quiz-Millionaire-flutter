// To parse this JSON data, do
//
//     final jwtResponse = jwtResponseFromJson(jsonString);

import 'dart:convert';

JwtResponse jwtResponseFromJson(String str) => JwtResponse.fromJson(json.decode(str));

String jwtResponseToJson(JwtResponse data) => json.encode(data.toJson());

class JwtResponse {
  JwtResponse({
    this.jwtToken,
  });

  String jwtToken;

  factory JwtResponse.fromJson(Map<String, dynamic> json) => JwtResponse(
    jwtToken: json["jwtToken"],
  );

  Map<String, dynamic> toJson() => {
    "jwtToken": jwtToken,
  };
}