// To parse this JSON data, do
//
//     final dashboardlistmodel = dashboardlistmodelFromJson(jsonString);

import 'dart:convert';

PaymentsPageModel paymentspagemodelFromJson(String str) =>
    PaymentsPageModel.fromJson(json.decode(str));

String paymentspagemodelToJson(PaymentsPageModel data) =>
    json.encode(data.toJson());

class PaymentsPageModel {
  String status;
  List<Payments> list;
  String code;
  String message;

  PaymentsPageModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory PaymentsPageModel.fromJson(Map<String, dynamic> json) =>
      PaymentsPageModel(
        status: json["status"],
        list:
            List<Payments>.from(json["list"].map((x) => Payments.fromJson(x))),
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

class Payments {
  int id;
  String storename;
  String date;
  String totalorder;
  String totalorderamount;
  String tostore;
  String aggregator;
  String giventostore;
  String pendingtostore;

  int status;
  int active;
  int createdBy;
  dynamic createdDate;
  int updatedBy;
  dynamic updatedDate;

  Payments({
    required this.id,
    required this.storename,
    required this.date,
    required this.totalorder,
    required this.totalorderamount,
    required this.tostore,
    required this.aggregator,
    required this.giventostore,
    required this.pendingtostore,
    required this.status,
    required this.active,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory Payments.fromJson(Map<String, dynamic> json) => Payments(
        id: json["id"],
        storename: json["storename"],
        date: json["date"],
        totalorder: json["totalorder"],
        totalorderamount: json["totalorderamount"],
        tostore: json["tostore"],
        aggregator: json["aggregator"],
        giventostore: json["giventostore"],
        pendingtostore: json["pendingtostore"],
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
        "date": date,
        "totalorder": totalorder,
        "totalorderamount": totalorderamount,
        "aggregator": aggregator,
        "tostore": tostore,
        "tostorgiventostore": giventostore,
        "pendingtostore": pendingtostore,
        "status": status,
        "active": active,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}
