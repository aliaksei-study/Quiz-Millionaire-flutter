// To parse this JSON data, do
//
//     final answer = answerFromJson(jsonString);

import 'dart:convert';

Answer answerFromJson(String str) => Answer.fromJson(json.decode(str));

String answerToJson(Answer data) => json.encode(data.toJson());

class Answer {
  Answer({
    this.id,
    this.answerText,
    this.isCorrect,
  });

  int id;
  String answerText;
  bool isCorrect;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    id: json["id"],
    answerText: json["answerText"],
    isCorrect: json["isCorrect"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "answerText": answerText,
    "isCorrect": isCorrect,
  };
}