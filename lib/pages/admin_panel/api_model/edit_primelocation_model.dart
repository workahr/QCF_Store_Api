// To parse this JSON data, do
//
//     final editPrimeLocationByIdModel = editPrimeLocationByIdModelFromJson(jsonString);

import 'dart:convert';

EditPrimeLocationByIdModel editPrimeLocationByIdModelFromJson(String str) =>
    EditPrimeLocationByIdModel.fromJson(json.decode(str));

String editPrimeLocationByIdModelToJson(EditPrimeLocationByIdModel data) =>
    json.encode(data.toJson());

class EditPrimeLocationByIdModel {
  String status;
  EditPrime list;
  String code;
  String message;

  EditPrimeLocationByIdModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory EditPrimeLocationByIdModel.fromJson(Map<String, dynamic> json) =>
      EditPrimeLocationByIdModel(
        status: json["status"],
        list: EditPrime.fromJson(json["list"]),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "list": list.toJson(),
        "code": code,
        "message": message,
      };
}

class EditPrime {
  int id;
  String name;
  int serial;
  int status;
  int createdBy;
  DateTime createdDate;
  dynamic updatedBy;
  dynamic updatedDate;

  EditPrime({
    required this.id,
    required this.name,
    required this.serial,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory EditPrime.fromJson(Map<String, dynamic> json) => EditPrime(
        id: json["id"],
        name: json["name"],
        serial: json["serial"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "serial": serial,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}
