// To parse this JSON data, do
//
//     final categoryListmodel = categoryListmodelFromJson(jsonString);

import 'dart:convert';

AdminCategoryListmodel admincategoryListmodelFromJson(String str) =>
    AdminCategoryListmodel.fromJson(json.decode(str));

String admincategoryListmodelToJson(AdminCategoryListmodel data) =>
    json.encode(data.toJson());

class AdminCategoryListmodel {
  String status;
  List<AdmminCategoryList> list;
  String code;
  String message;

  AdminCategoryListmodel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory AdminCategoryListmodel.fromJson(Map<String, dynamic> json) =>
      AdminCategoryListmodel(
        status: json["status"],
        list: List<AdmminCategoryList>.from(
            json["list"].map((x) => AdmminCategoryList.fromJson(x))),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "code": code,
        "message": message,
      };
}

class AdmminCategoryList {
  int categoryId;
  int? storeId;
  String? categoryName;
  String? description;
  String? slug;
  int? serial;
  String? imageUrl;
  int? status;
  int? createdBy;
  DateTime? createdDate;
  dynamic updatedBy;
  dynamic updatedDate;

  AdmminCategoryList({
    required this.categoryId,
    this.storeId,
    this.categoryName,
    this.description,
    this.slug,
    this.serial,
    this.imageUrl,
    this.status,
    this.createdBy,
    this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory AdmminCategoryList.fromJson(Map<String, dynamic> json) =>
      AdmminCategoryList(
        categoryId: json["category_id"],
        storeId: json["store_id"],
        categoryName: json["category_name"],
        description: json["description"],
        slug: json["slug"],
        serial: json["serial"],
        imageUrl: json["image_url"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
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
        "created_date": createdDate?.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}
