// To parse this JSON data, do
//
//     final deleteDeliveryPersonmodel = deleteDeliveryPersonmodelFromJson(jsonString);

import 'dart:convert';

DeleteDeliveryPersonmodel deleteDeliveryPersonmodelFromJson(String str) =>
    DeleteDeliveryPersonmodel.fromJson(json.decode(str));

String deleteDeliveryPersonmodelToJson(DeleteDeliveryPersonmodel data) =>
    json.encode(data.toJson());

class DeleteDeliveryPersonmodel {
  String status;
  String code;
  String message;

  DeleteDeliveryPersonmodel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory DeleteDeliveryPersonmodel.fromJson(Map<String, dynamic> json) =>
      DeleteDeliveryPersonmodel(
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
