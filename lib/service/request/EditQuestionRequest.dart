// To parse this JSON data, do
//
//     final editQuestionRequest = editQuestionRequestFromJson(jsonString);

import 'dart:convert';

import 'package:quiz_millionaire_flutter_test/entity/Category.dart';

EditQuestionRequest editQuestionRequestFromJson(String str) => EditQuestionRequest.fromJson(json.decode(str));

String editQuestionRequestToJson(EditQuestionRequest data) => json.encode(data.toJson());

class EditQuestionRequest {
  EditQuestionRequest({
    this.category,
    this.difficulty,
    this.isTemporal,
  });

  Category category;
  String difficulty;
  bool isTemporal;

  factory EditQuestionRequest.fromJson(Map<String, dynamic> json) => EditQuestionRequest(
    category: Category.fromJson(json["category"]),
    difficulty: json["difficulty"],
    isTemporal: json["isTemporal"],
  );

  Map<String, dynamic> toJson() => {
    "category": category.toJson(),
    "difficulty": difficulty,
    "isTemporal": isTemporal,
  };
}
