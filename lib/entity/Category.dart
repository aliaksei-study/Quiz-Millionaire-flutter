// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoriesFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoriesToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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