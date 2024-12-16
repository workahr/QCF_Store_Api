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
  AdminEditCategory list;
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
        list: AdminEditCategory.fromJson(json["list"]),
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

class AdminEditCategory {
  int? categoryId;
  int? storeId;
  String? categoryName;
  String? description;
  String? slug;
  int? serial;
  String? imageUrl;
  int? status;
  int? createdBy;
  String? createdDate;
  int? updatedBy;
  String? updatedDate;

  AdminEditCategory({
    this.categoryId,
    this.storeId,
    this.categoryName,
    this.description,
    this.slug,
    this.serial,
    this.imageUrl,
    this.status,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
  });

  factory AdminEditCategory.fromJson(Map<String, dynamic> json) =>
      AdminEditCategory(
        categoryId: json["category_id"],
        storeId: json["store_id"],
        categoryName: json["category_name"],
        description: json["description"],
        slug: json["slug"],
        serial: json["serial"],
        imageUrl: json["image_url"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: json["created_date"],
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
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}
