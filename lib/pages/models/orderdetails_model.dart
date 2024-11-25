// To parse this JSON data, do
//
//     final storemenulistmodel = storemenulistmodelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderdetailsmodelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

String orderdetailsmodelToJson(OrderDetailsModel data) =>
    json.encode(data.toJson());

class OrderDetailsModel {
  String status;
  List<DetailList> list;
  String code;
  String message;

  OrderDetailsModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        status: json["status"],
        list: List<DetailList>.from(
            json["list"].map((x) => DetailList.fromJson(x))),
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

class DetailList {
  int id;
  String dishtype;
  String dishname;

  String amount;
  String qty;
  int status;
  int active;
  int createdBy;
  dynamic createdDate;
  int updatedBy;
  dynamic updatedDate;

  DetailList({
    required this.id,
    required this.dishtype,
    required this.dishname,
    required this.amount,
    required this.qty,
    required this.status,
    required this.active,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory DetailList.fromJson(Map<String, dynamic> json) => DetailList(
        id: json["id"],
        dishtype: json["dishtype"],
        dishname: json["dishname"],
        amount: json["amount"],
        qty: json["qty"],
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
        "amount": amount,
        "qty": qty,
        "status": status,
        "active": active,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}
