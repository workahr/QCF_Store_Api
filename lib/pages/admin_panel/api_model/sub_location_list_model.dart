// To parse this JSON data, do
//
//     final subLocationListModel = subLocationListModelFromJson(jsonString);

import 'dart:convert';

SubLocationListModel subLocationListModelFromJson(String str) =>
    SubLocationListModel.fromJson(json.decode(str));

String subLocationListModelToJson(SubLocationListModel data) =>
    json.encode(data.toJson());

class SubLocationListModel {
  String status;
  List<SubList> list;
  String code;
  String message;

  SubLocationListModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory SubLocationListModel.fromJson(Map<String, dynamic> json) =>
      SubLocationListModel(
        status: json["status"],
        list: List<SubList>.from(json["list"].map((x) => SubList.fromJson(x))),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "code": code,
        "message": message,
      };
}

class SubList {
  int id;
  String? name;
  int? serial;
  int? mainLocationId;
  String? price;
  int status;
  int createdBy;
  DateTime createdDate;
  dynamic updatedBy;
  dynamic updatedDate;

  SubList({
    required this.id,
    this.name,
    this.serial,
    this.mainLocationId,
    this.price,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory SubList.fromJson(Map<String, dynamic> json) => SubList(
        id: json["id"],
        name: json["name"],
        serial: json["serial"],
        mainLocationId: json["main_location_id"],
        price: json["price"],
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
        "main_location_id": mainLocationId,
        "price": price,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}
