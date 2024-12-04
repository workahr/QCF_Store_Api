// To parse this JSON data, do
//
//     final addpaymentmodel = addpaymentmodelFromJson(jsonString);

import 'dart:convert';

Addpaymentmodel addpaymentmodelFromJson(String str) =>
    Addpaymentmodel.fromJson(json.decode(str));

String addpaymentmodelToJson(Addpaymentmodel data) =>
    json.encode(data.toJson());

class Addpaymentmodel {
  String status;
  String code;
  String message;

  Addpaymentmodel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory Addpaymentmodel.fromJson(Map<String, dynamic> json) =>
      Addpaymentmodel(
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
