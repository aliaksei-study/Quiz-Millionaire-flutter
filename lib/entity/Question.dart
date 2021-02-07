// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'dart:convert';

import 'package:quiz_millionaire_flutter_test/entity/Difficulty.dart';

import 'Answer.dart';
import 'Category.dart';

List<Question> questionsFromJson(String str) => List<Question>.from(json.decode(str).map((x) => Question.fromJson(x)));

String questionsToJson(List<Question> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

class Question {
  Question({
    this.id,
    this.questionText,
    this.difficulty,
    this.isTemporal,
    this.answers,
    this.category,
  });

  int id;
  String questionText;
  String difficulty;
  bool isTemporal;
  List<Answer> answers;
  Category category;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    questionText: json["questionText"],
    difficulty: json["difficulty"],
    isTemporal: json["isTemporal"],
    answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
    category: Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "questionText": questionText,
    "difficulty": difficulty,
    "isTemporal": isTemporal,
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
    "category": category.toJson(),
  };
}