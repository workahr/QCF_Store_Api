// To parse this JSON data, do
//
//     final editSubLocationByIdModel = editSubLocationByIdModelFromJson(jsonString);

import 'dart:convert';

EditSubLocationByIdModel editSubLocationByIdModelFromJson(String str) =>
    EditSubLocationByIdModel.fromJson(json.decode(str));

String editSubLocationByIdModelToJson(EditSubLocationByIdModel data) =>
    json.encode(data.toJson());

class EditSubLocationByIdModel {
  String status;
  EditSub list;
  String code;
  String message;

  EditSubLocationByIdModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory EditSubLocationByIdModel.fromJson(Map<String, dynamic> json) =>
      EditSubLocationByIdModel(
        status: json["status"],
        list: EditSub.fromJson(json["list"]),
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

class EditSub {
  int id;
  String name;
  int serial;
  int mainLocationId;
  String price;
  int status;
  int createdBy;
  DateTime createdDate;
  int updatedBy;
  DateTime updatedDate;

  EditSub({
    required this.id,
    required this.name,
    required this.serial,
    required this.mainLocationId,
    required this.price,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory EditSub.fromJson(Map<String, dynamic> json) => EditSub(
        id: json["id"],
        name: json["name"],
        serial: json["serial"],
        mainLocationId: json["main_location_id"],
        price: json["price"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: DateTime.parse(json["updated_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "serial": serial,
        "main_location_id": mainLocationId,
        "price": price,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate.toIso8601String(),
      };
}
