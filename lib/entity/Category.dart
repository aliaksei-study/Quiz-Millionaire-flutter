// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.id,
    this.categoryName,
  });

  int id;
  String categoryName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    categoryName: json["categoryName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryName": categoryName,
  };
}