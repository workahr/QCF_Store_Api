// To parse this JSON data, do
//
//     final storeStatusUpdatemodel = storeStatusUpdatemodelFromJson(jsonString);

import 'dart:convert';

TotalStoreStatusUpdateAdminmodel totalstoreStatusUpdatemodelFromJson(
        String str) =>
    TotalStoreStatusUpdateAdminmodel.fromJson(json.decode(str));

String totalstoreStatusUpdatemodelToJson(
        TotalStoreStatusUpdateAdminmodel data) =>
    json.encode(data.toJson());

class TotalStoreStatusUpdateAdminmodel {
  String status;
  String code;
  String message;

  TotalStoreStatusUpdateAdminmodel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory TotalStoreStatusUpdateAdminmodel.fromJson(
          Map<String, dynamic> json) =>
      TotalStoreStatusUpdateAdminmodel(
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
