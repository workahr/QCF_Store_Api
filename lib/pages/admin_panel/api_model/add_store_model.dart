// To parse this JSON data, do
//
//     final addstoremodel = addstoremodelFromJson(jsonString);

import 'dart:convert';

Addstoremodel addstoremodelFromJson(String str) =>
    Addstoremodel.fromJson(json.decode(str));

String addstoremodelToJson(Addstoremodel data) => json.encode(data.toJson());

class Addstoremodel {
  String status;
  String code;
  String message;

  Addstoremodel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory Addstoremodel.fromJson(Map<String, dynamic> json) => Addstoremodel(
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
