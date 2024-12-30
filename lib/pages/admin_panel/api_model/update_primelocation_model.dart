// To parse this JSON data, do
//
//     final updatePrimeLocationModel = updatePrimeLocationModelFromJson(jsonString);

import 'dart:convert';

UpdatePrimeLocationModel updatePrimeLocationModelFromJson(String str) =>
    UpdatePrimeLocationModel.fromJson(json.decode(str));

String updatePrimeLocationModelToJson(UpdatePrimeLocationModel data) =>
    json.encode(data.toJson());

class UpdatePrimeLocationModel {
  String status;
  String code;
  String message;

  UpdatePrimeLocationModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory UpdatePrimeLocationModel.fromJson(Map<String, dynamic> json) =>
      UpdatePrimeLocationModel(
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
