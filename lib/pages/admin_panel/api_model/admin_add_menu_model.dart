// To parse this JSON data, do
//
//     final addMenumodel = addMenumodelFromJson(jsonString);

import 'dart:convert';

AdminAddMenumodel adminaddMenumodelFromJson(String str) =>
    AdminAddMenumodel.fromJson(json.decode(str));

String adminaddMenumodelToJson(AdminAddMenumodel data) =>
    json.encode(data.toJson());

class AdminAddMenumodel {
  String status;
  String code;
  String message;

  AdminAddMenumodel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory AdminAddMenumodel.fromJson(Map<String, dynamic> json) =>
      AdminAddMenumodel(
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
