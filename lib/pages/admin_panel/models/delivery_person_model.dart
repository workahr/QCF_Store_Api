// To parse this JSON data, do
//
//     final dashboardlistmodel = dashboardlistmodelFromJson(jsonString);

import 'dart:convert';

DeliveryPersonModel deliverypersonmodelFromJson(String str) =>
    DeliveryPersonModel.fromJson(json.decode(str));

String deliverypersonmodelToJson(DeliveryPersonModel data) =>
    json.encode(data.toJson());

class DeliveryPersonModel {
  String status;
  List<deliverypersons> list;
  String code;
  String message;

  DeliveryPersonModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory DeliveryPersonModel.fromJson(Map<String, dynamic> json) =>
      DeliveryPersonModel(
        status: json["status"],
        list: List<deliverypersons>.from(
            json["list"].map((x) => deliverypersons.fromJson(x))),
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

class deliverypersons {
  int id;
  String image;
  String title;

  int status;
  int active;
  int createdBy;
  dynamic createdDate;
  int updatedBy;
  dynamic updatedDate;

  deliverypersons({
    required this.id,
    required this.image,
    required this.title,
    required this.status,
    required this.active,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory deliverypersons.fromJson(Map<String, dynamic> json) =>
      deliverypersons(
        id: json["id"],
        image: json["image"],
        title: json["title"],
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
        "status": status,
        "active": active,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}
