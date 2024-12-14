// To parse this JSON data, do
//
//     final addCategorymodel = addCategorymodelFromJson(jsonString);

import 'dart:convert';

import 'package:namstore/pages/store_menu/category_list_model.dart';

AdminMenuAddCategorymodel adminmenuaddCategorymodelFromJson(String str) =>
    AdminMenuAddCategorymodel.fromJson(json.decode(str));

String adminmenuaddCategorymodelToJson(AdminMenuAddCategorymodel data) =>
    json.encode(data.toJson());

class AdminMenuAddCategorymodel {
  String status;
  String code;
  String message;

  AdminMenuAddCategorymodel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory AdminMenuAddCategorymodel.fromJson(Map<String, dynamic> json) =>
      AdminMenuAddCategorymodel(
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
