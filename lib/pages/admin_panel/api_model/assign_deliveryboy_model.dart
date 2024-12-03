// To parse this JSON data, do
//
//     final assignDeliveryBoymodel = assignDeliveryBoymodelFromJson(jsonString);

import 'dart:convert';

AssignDeliveryBoymodel assignDeliveryBoymodelFromJson(String str) =>
    AssignDeliveryBoymodel.fromJson(json.decode(str));

String assignDeliveryBoymodelToJson(AssignDeliveryBoymodel data) =>
    json.encode(data.toJson());

class AssignDeliveryBoymodel {
  String status;
  String code;
  String message;

  AssignDeliveryBoymodel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory AssignDeliveryBoymodel.fromJson(Map<String, dynamic> json) =>
      AssignDeliveryBoymodel(
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
