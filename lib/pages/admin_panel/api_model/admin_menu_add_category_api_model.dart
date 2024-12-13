// To parse this JSON data, do
//
//     final addCategorymodel = addCategorymodelFromJson(jsonString);

import 'dart:convert';

import 'package:namstore/pages/store_menu/category_list_model.dart';

AdminAddCategorymodel adminaddCategorymodelFromJson(String str) =>
    AdminAddCategorymodel.fromJson(json.decode(str));

String adminaddCategorymodelToJson(AdminAddCategorymodel data) =>
    json.encode(data.toJson());

class AdminAddCategorymodel {
  String status;
  String code;
  String message;

  AdminAddCategorymodel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory AdminAddCategorymodel.fromJson(Map<String, dynamic> json) =>
      AdminAddCategorymodel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
      );

  List<CategoryList>? get list => null;

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
      };
}
