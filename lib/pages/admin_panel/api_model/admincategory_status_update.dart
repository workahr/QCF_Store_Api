// To parse this JSON data, do
//
//     final categorystatusupdatemodel = categorystatusupdatemodelFromJson(jsonString);

import 'dart:convert';

Categorystatusupdatemodel categorystatusupdatemodelFromJson(String str) =>
    Categorystatusupdatemodel.fromJson(json.decode(str));

String categorystatusupdatemodelToJson(Categorystatusupdatemodel data) =>
    json.encode(data.toJson());

class Categorystatusupdatemodel {
  String status;
  String code;
  String message;

  Categorystatusupdatemodel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory Categorystatusupdatemodel.fromJson(Map<String, dynamic> json) =>
      Categorystatusupdatemodel(
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
