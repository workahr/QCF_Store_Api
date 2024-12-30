// To parse this JSON data, do
//
//     final primeLocationListModel = primeLocationListModelFromJson(jsonString);

import 'dart:convert';

PrimeLocationListModel primeLocationListModelFromJson(String str) =>
    PrimeLocationListModel.fromJson(json.decode(str));

String primeLocationListModelToJson(PrimeLocationListModel data) =>
    json.encode(data.toJson());

class PrimeLocationListModel {
  String status;
  List<PrimeList> list;
  String code;
  String message;

  PrimeLocationListModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory PrimeLocationListModel.fromJson(Map<String, dynamic> json) =>
      PrimeLocationListModel(
        status: json["status"],
        list: List<PrimeList>.from(
            json["list"].map((x) => PrimeList.fromJson(x))),
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

class PrimeList {
  int id;
  String? name;
  int serial;
  int status;
  int createdBy;
  DateTime createdDate;
  dynamic updatedBy;
  dynamic updatedDate;

  PrimeList({
    required this.id,
    this.name,
    required this.serial,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory PrimeList.fromJson(Map<String, dynamic> json) => PrimeList(
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
