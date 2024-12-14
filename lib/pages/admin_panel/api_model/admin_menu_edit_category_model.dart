// To parse this JSON data, do
//
//     final deleteCategoryByIdModel = deleteCategoryByIdModelFromJson(jsonString);

import 'dart:convert';

AdminMenuEditCategoryByIdModel adminmenueditCategoryByIdModelFromJson(
        String str) =>
    AdminMenuEditCategoryByIdModel.fromJson(json.decode(str));

String adminmenueditCategoryByIdModelToJson(
        AdminMenuEditCategoryByIdModel data) =>
    json.encode(data.toJson());

class AdminMenuEditCategoryByIdModel {
  String status;
  EditCategory list;
  String code;
  String message;

  AdminMenuEditCategoryByIdModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory AdminMenuEditCategoryByIdModel.fromJson(Map<String, dynamic> json) =>
      AdminMenuEditCategoryByIdModel(
        status: json["status"],
        list: EditCategory.fromJson(json["list"]),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "list": list.toJson(),
        "code": code,
        "message": message,
      };
}

class EditCategory {
  int categoryId;
  int storeId;
  String categoryName;
  dynamic description;
  String slug;
  dynamic serial;
  dynamic imageUrl;
  int status;
  int createdBy;
  DateTime createdDate;
  dynamic updatedBy;
  dynamic updatedDate;

  EditCategory({
    required this.categoryId,
    required this.storeId,
    required this.categoryName,
    required this.description,
    required this.slug,
    required this.serial,
    required this.imageUrl,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory EditCategory.fromJson(Map<String, dynamic> json) => EditCategory(
        categoryId: json["category_id"],
        storeId: json["store_id"],
        categoryName: json["category_name"],
        description: json["description"],
        slug: json["slug"],
        serial: json["serial"],
        imageUrl: json["image_url"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "store_id": storeId,
        "category_name": categoryName,
        "description": description,
        "slug": slug,
        "serial": serial,
        "image_url": imageUrl,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}
