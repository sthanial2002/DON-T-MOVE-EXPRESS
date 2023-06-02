// To parse this JSON data, do
//
//     final onboardingModel = onboardingModelFromJson(jsonString);

import 'dart:convert';

List<OnboardingModel> onboardingModelFromJson(String str) =>
    List<OnboardingModel>.from(
        json.decode(str).map((x) => OnboardingModel.fromJson(x)));

String onboardingModelToJson(List<OnboardingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OnboardingModel {
  OnboardingModel({
    this.id,
    this.inOrder,
    this.title,
    this.description,
    this.type,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.formattedDate,
    this.formattedUpdatedDate,
    this.photo,
  });

  int id;
  int inOrder;
  String title;
  String description;
  String type;
  int isActive;
  DateTime createdAt;
  DateTime updatedAt;
  String formattedDate;
  String formattedUpdatedDate;
  String photo;

  factory OnboardingModel.fromJson(Map<String, dynamic> json) =>
      OnboardingModel(
        id: json["id"] ?? '',
        inOrder: json["in_order"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        type: json["type"] ?? '',
        isActive: json["is_active"] ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        formattedDate: json["formatted_date"] ?? '',
        formattedUpdatedDate: json["formatted_updated_date"] ?? '',
        photo: json["photo"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "in_order": inOrder,
        "title": title,
        "description": description,
        "type": type,
        "is_active": isActive,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "formatted_date": formattedDate,
        "formatted_updated_date": formattedUpdatedDate,
        "photo": photo,
      };
}
