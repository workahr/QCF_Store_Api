// To parse this JSON data, do
//
//     final deleteCategoryByIdModel = deleteCategoryByIdModelFromJson(jsonString);

import 'dart:convert';

EditCategoryByIdModel editCategoryByIdModelFromJson(String str) =>
    EditCategoryByIdModel.fromJson(json.decode(str));

String editCategoryByIdModelToJson(EditCategoryByIdModel data) =>
    json.encode(data.toJson());

class EditCategoryByIdModel {
  String status;
  EditCategory list;
  String code;
  String message;

  EditCategoryByIdModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory EditCategoryByIdModel.fromJson(Map<String, dynamic> json) =>
      EditCategoryByIdModel(
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

  EditCategory({
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
