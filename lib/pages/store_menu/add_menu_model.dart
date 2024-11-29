// To parse this JSON data, do
//
//     final addMenumodel = addMenumodelFromJson(jsonString);

import 'dart:convert';

AddMenumodel addMenumodelFromJson(String str) =>
    AddMenumodel.fromJson(json.decode(str));

String addMenumodelToJson(AddMenumodel data) => json.encode(data.toJson());

class AddMenumodel {
  String status;
  String code;
  String message;

  AddMenumodel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory AddMenumodel.fromJson(Map<String, dynamic> json) => AddMenumodel(
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
