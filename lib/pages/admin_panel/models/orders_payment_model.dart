// To parse this JSON data, do
//
//     final dashboardlistmodel = dashboardlistmodelFromJson(jsonString);

import 'dart:convert';

OrdersPaymentModel orderspaymentmodelFromJson(String str) =>
    OrdersPaymentModel.fromJson(json.decode(str));

String orderspaymentmodelToJson(OrdersPaymentModel data) =>
    json.encode(data.toJson());

class OrdersPaymentModel {
  String status;
  List<OrdersPaymentList> list;
  String code;
  String message;

  OrdersPaymentModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory OrdersPaymentModel.fromJson(Map<String, dynamic> json) =>
      OrdersPaymentModel(
        status: json["status"],
        list: List<OrdersPaymentList>.from(
            json["list"].map((x) => OrdersPaymentList.fromJson(x))),
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

class OrdersPaymentList {
  int id;
  String orderid;
  String items;
  String time;
  String date;
  String amount;
  String delivery;

  int status;
  int active;
  int createdBy;
  dynamic createdDate;
  int updatedBy;
  dynamic updatedDate;

  OrdersPaymentList({
    required this.id,
    required this.orderid,
    required this.items,
    required this.time,
    required this.date,
    required this.amount,
    required this.delivery,
    required this.status,
    required this.active,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory OrdersPaymentList.fromJson(Map<String, dynamic> json) =>
      OrdersPaymentList(
        id: json["id"],
        orderid: json["orderid"],
        items: json["items"],
        time: json["time"],
        date: json["date"],
        amount: json["amount"],
        delivery: json["delivery"],
        status: json["status"],
        active: json["active"],
        createdBy: json["created_by"],
        createdDate: json["created_date"],
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderid": orderid,
        "items": items,
        "time": time,
        "date": date,
        "amount": amount,
        "delivery": delivery,
        "status": status,
        "active": active,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}
