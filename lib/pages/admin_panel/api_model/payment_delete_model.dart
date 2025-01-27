// To parse this JSON data, do
//
//     final deletePrimeLocationModel = deletePrimeLocationModelFromJson(jsonString);

import 'dart:convert';

DeletePaymentModel deletePaymentModelFromJson(String str) =>
    DeletePaymentModel.fromJson(json.decode(str));

String deletePaymentModelToJson(DeletePaymentModel data) =>
    json.encode(data.toJson());

class DeletePaymentModel {
  String status;
  String code;
  String message;

  DeletePaymentModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory DeletePaymentModel.fromJson(Map<String, dynamic> json) =>
      DeletePaymentModel(
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
