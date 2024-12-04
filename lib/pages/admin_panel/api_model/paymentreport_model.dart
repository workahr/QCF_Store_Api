// To parse this JSON data, do
//
//     final paymentReportmodel = paymentReportmodelFromJson(jsonString);

import 'dart:convert';

PaymentReportmodel paymentReportmodelFromJson(String str) =>
    PaymentReportmodel.fromJson(json.decode(str));

String paymentReportmodelToJson(PaymentReportmodel data) =>
    json.encode(data.toJson());

class PaymentReportmodel {
  String status;
  List<PaymentList> list;
  String code;
  String message;

  PaymentReportmodel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory PaymentReportmodel.fromJson(Map<String, dynamic> json) =>
      PaymentReportmodel(
        status: json["status"],
        list: List<PaymentList>.from(
            json["list"].map((x) => PaymentList.fromJson(x))),
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

class PaymentList {
  int id;
  DateTime date;
  int storeId;
  dynamic orderIds;
  String amount;
  String paymentMethod;
  String? imageUrl;
  int status;
  int createdBy;
  DateTime createdDate;
  String storeName;
  String storeMobile;

  PaymentList({
    required this.id,
    required this.date,
    required this.storeId,
    required this.orderIds,
    required this.amount,
    required this.paymentMethod,
    required this.imageUrl,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    required this.storeName,
    required this.storeMobile,
  });

  factory PaymentList.fromJson(Map<String, dynamic> json) => PaymentList(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        storeId: json["store_id"],
        orderIds: json["order_ids"],
        amount: json["amount"],
        paymentMethod: json["payment_method"],
        imageUrl: json["image_url"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        storeName: json["store_name"],
        storeMobile: json["store_mobile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "store_id": storeId,
        "order_ids": orderIds,
        "amount": amount,
        "payment_method": paymentMethod,
        "image_url": imageUrl,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "store_name": storeName,
        "store_mobile": storeMobile,
      };
}
