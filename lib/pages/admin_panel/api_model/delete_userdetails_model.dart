// To parse this JSON data, do
//
//     final deletePrimeLocationModel = deletePrimeLocationModelFromJson(jsonString);

import 'dart:convert';

DeleteUserdetailsModel deleteUserdetailsModelFromJson(String str) =>
    DeleteUserdetailsModel.fromJson(json.decode(str));

String deleteUserdetailsModelToJson(DeleteUserdetailsModel data) =>
    json.encode(data.toJson());

class DeleteUserdetailsModel {
  String status;
  String code;
  String message;

  DeleteUserdetailsModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory DeleteUserdetailsModel.fromJson(Map<String, dynamic> json) =>
      DeleteUserdetailsModel(
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
