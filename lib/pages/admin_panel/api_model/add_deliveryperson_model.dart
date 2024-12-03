// To parse this JSON data, do
//
//     final addDeliveryPersonmodel = addDeliveryPersonmodelFromJson(jsonString);

import 'dart:convert';

AddDeliveryPersonmodel addDeliveryPersonmodelFromJson(String str) =>
    AddDeliveryPersonmodel.fromJson(json.decode(str));

String addDeliveryPersonmodelToJson(AddDeliveryPersonmodel data) =>
    json.encode(data.toJson());

class AddDeliveryPersonmodel {
  String status;
  String code;
  String message;

  AddDeliveryPersonmodel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory AddDeliveryPersonmodel.fromJson(Map<String, dynamic> json) =>
      AddDeliveryPersonmodel(
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
