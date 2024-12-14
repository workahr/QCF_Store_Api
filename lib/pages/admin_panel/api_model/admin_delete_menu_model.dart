// To parse this JSON data, do
//
//     final deleteStoremodel = deleteStoremodelFromJson(jsonString);

import 'dart:convert';

AdminDeleteMenumodel admindeletemenumodelFromJson(String str) =>
    AdminDeleteMenumodel.fromJson(json.decode(str));

String admindeletemenumodelToJson(AdminDeleteMenumodel data) =>
    json.encode(data.toJson());

class AdminDeleteMenumodel {
  String status;
  String code;
  String message;

  AdminDeleteMenumodel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory AdminDeleteMenumodel.fromJson(Map<String, dynamic> json) =>
      AdminDeleteMenumodel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
      };
}
