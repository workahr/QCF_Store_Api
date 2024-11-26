// To parse this JSON data, do
//
//     final orderlistmodel = orderlistmodelFromJson(jsonString);

import 'dart:convert';

Orderlistmodel orderlistmodelFromJson(String str) =>
    Orderlistmodel.fromJson(json.decode(str));

String orderlistmodelToJson(Orderlistmodel data) => json.encode(data.toJson());

class Orderlistmodel {
  String status;
  List<OrderList> list;
  String code;
  String message;

  Orderlistmodel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory Orderlistmodel.fromJson(Map<String, dynamic> json) => Orderlistmodel(
        status: json["status"],
        list: List<OrderList>.from(
            json["list"].map((x) => OrderList.fromJson(x))),
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

class OrderList {
  int id;
  String orderid;
  String ordereditem;
  String qty1;
  String qty2;
  String dish1;
  String dish2;
  String price1;
  String price2;
  String totalamount;
  String paymenttype;
  int status;
  int active;
  int createdBy;
  DateTime createdDate;
  int updatedBy;
  dynamic updatedDate;

  OrderList({
    required this.id,
    required this.orderid,
    required this.ordereditem,
    required this.qty1,
    required this.qty2,
    required this.dish1,
    required this.dish2,
    required this.price1,
    required this.price2,
    required this.totalamount,
    required this.paymenttype,
    required this.status,
    required this.active,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        id: json["id"],
        orderid: json["orderid"],
        ordereditem: json["ordereditem"],
        qty1: json["qty1"],
        qty2: json["qty2"],
        dish1: json["dish1"],
        dish2: json["dish2"],
        price1: json["price1"],
        price2: json["price2"],
        totalamount: json["totalamount"],
        paymenttype: json["paymenttype"],
        status: json["status"],
        active: json["active"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderid": orderid,
        "ordereditem": ordereditem,
        "qty1": qty1,
        "qty2": qty2,
        "dish1": dish1,
        "dish2": dish2,
        "price1": price1,
        "price2": price2,
        "totalamount": totalamount,
        "paymenttype": paymenttype,
        "status": status,
        "active": active,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}
