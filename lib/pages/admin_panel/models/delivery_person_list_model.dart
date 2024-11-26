// To parse this JSON data, do
//
//     final dashboardlistmodel = dashboardlistmodelFromJson(jsonString);

import 'dart:convert';

DeliveryPersonListModel deliverypersonlistmodelFromJson(String str) =>
    DeliveryPersonListModel.fromJson(json.decode(str));

String deliverypersonlistmodelToJson(DeliveryPersonListModel data) =>
    json.encode(data.toJson());

class DeliveryPersonListModel {
  String status;
  List<Lists> list;
  String code;
  String message;

  DeliveryPersonListModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory DeliveryPersonListModel.fromJson(Map<String, dynamic> json) =>
      DeliveryPersonListModel(
        status: json["status"],
        list: List<Lists>.from(json["list"].map((x) => Lists.fromJson(x))),
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

class Lists {
  int id;
  String image;
  String title;
  int? mobilenumber;

  int status;
  int active;
  int createdBy;
  dynamic createdDate;
  int updatedBy;
  dynamic updatedDate;

  Lists({
    required this.id,
    required this.image,
    required this.title,
    this.mobilenumber,
    required this.status,
    required this.active,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory Lists.fromJson(Map<String, dynamic> json) => Lists(
        id: json["id"],
        image: json["image"],
        title: json["title"],
        mobilenumber: json["mobilenumber"],
        status: json["status"],
        active: json["active"],
        createdBy: json["created_by"],
        createdDate: json["created_date"],
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "title": title,
        "mobilenumber": mobilenumber,
        "status": status,
        "active": active,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}
