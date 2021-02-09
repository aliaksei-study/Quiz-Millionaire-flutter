// To parse this JSON data, do
//
//     final answer = answerFromJson(jsonString);

import 'dart:convert';

List<Player> playersFromJson(String str) => List<Player>.from(json.decode(str).map((x) => Player.fromJson(x)));

String playersToJson(List<Player> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Player playerFromJson(String str) => Player.fromJson(json.decode(str));

String playerToJson(Player data) => json.encode(data.toJson());

class Player {
  Player({
    this.id,
    this.username,
    this.role,
  });

  int id;
  String username;
  String role;

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    id: json["id"],
    username: json["username"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "role": role,
  };
}