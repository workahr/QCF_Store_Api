// To parse this JSON data, do
//
//     final addPrimeLocationModel = addPrimeLocationModelFromJson(jsonString);

import 'dart:convert';

AddPrimeLocationModel addPrimeLocationModelFromJson(String str) =>
    AddPrimeLocationModel.fromJson(json.decode(str));

String addPrimeLocationModelToJson(AddPrimeLocationModel data) =>
    json.encode(data.toJson());

class AddPrimeLocationModel {
  String status;
  String code;
  String message;

  AddPrimeLocationModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory AddPrimeLocationModel.fromJson(Map<String, dynamic> json) =>
      AddPrimeLocationModel(
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
