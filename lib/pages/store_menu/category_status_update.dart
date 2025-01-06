// To parse this JSON data, do
//
//     final categorystatusupdatemodel = categorystatusupdatemodelFromJson(jsonString);

import 'dart:convert';

Categorystorestatusupdatemodel categorystorestatusupdatemodelFromJson(
        String str) =>
    Categorystorestatusupdatemodel.fromJson(json.decode(str));

String categorystorestatusupdatemodelToJson(
        Categorystorestatusupdatemodel data) =>
    json.encode(data.toJson());

class Categorystorestatusupdatemodel {
  String status;
  String code;
  String message;

  Categorystorestatusupdatemodel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory Categorystorestatusupdatemodel.fromJson(Map<String, dynamic> json) =>
      Categorystorestatusupdatemodel(
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
