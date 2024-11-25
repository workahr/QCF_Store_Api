// To parse this JSON data, do
//
//     final storemenulistmodel = storemenulistmodelFromJson(jsonString);

import 'dart:convert';

Storemenulistmodel storemenulistmodelFromJson(String str) =>
    Storemenulistmodel.fromJson(json.decode(str));

String storemenulistmodelToJson(Storemenulistmodel data) =>
    json.encode(data.toJson());

class Storemenulistmodel {
  String status;
  List<MenuDetailList> list;
  String code;
  String message;

  Storemenulistmodel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory Storemenulistmodel.fromJson(Map<String, dynamic> json) =>
      Storemenulistmodel(
        status: json["status"],
        list: List<MenuDetailList>.from(
            json["list"].map((x) => MenuDetailList.fromJson(x))),
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

class MenuDetailList {
  int id;
  String dishtype;
  String dishname;
  String image;
  String amount;
  bool stock;
  int status;
  int active;
  int createdBy;
  dynamic createdDate;
  int updatedBy;
  dynamic updatedDate;

  MenuDetailList({
    required this.id,
    required this.dishtype,
    required this.dishname,
    required this.image,
    required this.amount,
    required this.stock,
    required this.status,
    required this.active,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory MenuDetailList.fromJson(Map<String, dynamic> json) => MenuDetailList(
        id: json["id"],
        dishtype: json["dishtype"],
        dishname: json["dishname"],
        image: json["image"],
        amount: json["amount"],
        stock: json["stock"],
        status: json["status"],
        active: json["active"],
        createdBy: json["created_by"],
        createdDate: json["created_date"],
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dishtype": dishtype,
        "dishname": dishname,
        "image": image,
        "amount": amount,
        "stock": stock,
        "status": status,
        "active": active,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}
