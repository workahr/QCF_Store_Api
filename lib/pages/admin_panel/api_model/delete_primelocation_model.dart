// To parse this JSON data, do
//
//     final deletePrimeLocationModel = deletePrimeLocationModelFromJson(jsonString);

import 'dart:convert';

DeletePrimeLocationModel deletePrimeLocationModelFromJson(String str) =>
    DeletePrimeLocationModel.fromJson(json.decode(str));

String deletePrimeLocationModelToJson(DeletePrimeLocationModel data) =>
    json.encode(data.toJson());

class DeletePrimeLocationModel {
  String status;
  String code;
  String message;

  DeletePrimeLocationModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory DeletePrimeLocationModel.fromJson(Map<String, dynamic> json) =>
      DeletePrimeLocationModel(
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
