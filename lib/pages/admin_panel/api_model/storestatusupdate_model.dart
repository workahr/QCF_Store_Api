// To parse this JSON data, do
//
//     final storeStatusUpdatemodel = storeStatusUpdatemodelFromJson(jsonString);

import 'dart:convert';

StoreStatusUpdateAdminmodel storeStatusUpdatemodelFromJson(String str) =>
    StoreStatusUpdateAdminmodel.fromJson(json.decode(str));

String storeStatusUpdatemodelToJson(StoreStatusUpdateAdminmodel data) =>
    json.encode(data.toJson());

class StoreStatusUpdateAdminmodel {
  String status;
  String code;
  String message;

  StoreStatusUpdateAdminmodel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory StoreStatusUpdateAdminmodel.fromJson(Map<String, dynamic> json) =>
      StoreStatusUpdateAdminmodel(
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
