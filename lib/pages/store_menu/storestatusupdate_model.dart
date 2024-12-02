// To parse this JSON data, do
//
//     final storeStatusUpdatemodel = storeStatusUpdatemodelFromJson(jsonString);

import 'dart:convert';

StoreStatusUpdatemodel storeStatusUpdatemodelFromJson(String str) =>
    StoreStatusUpdatemodel.fromJson(json.decode(str));

String storeStatusUpdatemodelToJson(StoreStatusUpdatemodel data) =>
    json.encode(data.toJson());

class StoreStatusUpdatemodel {
  String status;
  String code;
  String message;

  StoreStatusUpdatemodel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory StoreStatusUpdatemodel.fromJson(Map<String, dynamic> json) =>
      StoreStatusUpdatemodel(
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
