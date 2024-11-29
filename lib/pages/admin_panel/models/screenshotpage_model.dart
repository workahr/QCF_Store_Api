// To parse this JSON data, do
//
//     final dashboardlistmodel = dashboardlistmodelFromJson(jsonString);

import 'dart:convert';

ScreenshotPageModel screenshotpagemodelFromJson(String str) =>
    ScreenshotPageModel.fromJson(json.decode(str));

String screenshotpagemodelToJson(ScreenshotPageModel data) =>
    json.encode(data.toJson());

class ScreenshotPageModel {
  String status;
  List<ScreeenShots> list;
  String code;
  String message;

  ScreenshotPageModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory ScreenshotPageModel.fromJson(Map<String, dynamic> json) =>
      ScreenshotPageModel(
        status: json["status"],
        list: List<ScreeenShots>.from(
            json["list"].map((x) => ScreeenShots.fromJson(x))),
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

class ScreeenShots {
  int id;
  String storename;
  String address;
  String mobilenumber;
  String name;
  String date;
  String amount;
  String image;
  String imageno;

  int status;
  int active;
  int createdBy;
  dynamic createdDate;
  int updatedBy;
  dynamic updatedDate;

  ScreeenShots({
    required this.id,
    required this.storename,
    required this.address,
    required this.mobilenumber,
    required this.name,
    required this.date,
    required this.amount,
    required this.image,
    required this.imageno,
    required this.status,
    required this.active,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory ScreeenShots.fromJson(Map<String, dynamic> json) => ScreeenShots(
        id: json["id"],
        storename: json["storename"],
        address: json["address"],
        mobilenumber: json["mobilenumber"],
        name: json["name"],
        date: json["date"],
        amount: json["amount"],
        image: json["image"],
        imageno: json["imageno"],
        status: json["status"],
        active: json["active"],
        createdBy: json["created_by"],
        createdDate: json["created_date"],
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "storename": storename,
        "address": address,
        "mobilenumber": mobilenumber,
        "date": date,
        "name": name,
        "amount": amount,
        "image": image,
        "imageno": imageno,
        "status": status,
        "active": active,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}
