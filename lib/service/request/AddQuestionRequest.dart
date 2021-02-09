// To parse this JSON data, do
//
//     final addQuestionRequest = addQuestionRequestFromJson(jsonString);

import 'dart:convert';

import 'package:quiz_millionaire_flutter_test/entity/Answer.dart';
import 'package:quiz_millionaire_flutter_test/entity/Category.dart';

AddQuestionRequest addQuestionRequestFromJson(String str) => AddQuestionRequest.fromJson(json.decode(str));

String addQuestionRequestToJson(AddQuestionRequest data) => json.encode(data.toJson());

class AddQuestionRequest {
  AddQuestionRequest({
    this.category,
    this.questionText,
    this.isTemporal,
    this.answers,
  });

  Category category;
  String questionText;
  bool isTemporal;
  List<Answer> answers;

  factory AddQuestionRequest.fromJson(Map<String, dynamic> json) => AddQuestionRequest(
    category: Category.fromJson(json["category"]),
    questionText: json["questionText"],
    isTemporal: json["isTemporal"],
    answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": category.toJson(),
    "questionText": questionText,
    "isTemporal": isTemporal,
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
  };
}