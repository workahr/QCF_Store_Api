// To parse this JSON data, do
//
//     final adminorderdetailslistmodel = adminorderdetailslistmodelFromJson(jsonString);

import 'dart:convert';

Adminorderdetailslistmodel adminorderdetailslistmodelFromJson(String str) =>
    Adminorderdetailslistmodel.fromJson(json.decode(str));

String adminorderdetailslistmodelToJson(Adminorderdetailslistmodel data) =>
    json.encode(data.toJson());

class Adminorderdetailslistmodel {
  String status;
  List<OrderDetailsList> list;
  String code;
  String message;

  Adminorderdetailslistmodel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory Adminorderdetailslistmodel.fromJson(Map<String, dynamic> json) =>
      Adminorderdetailslistmodel(
        status: json["status"],
        list: List<OrderDetailsList>.from(
            json["list"].map((x) => OrderDetailsList.fromJson(x))),
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

class OrderDetailsList {
  int id;
  String orderid;
  String orderstatus;
  String pickupaddress;
  String deliveryaddress;
  String totalamount;
  String deliverypersonName;
  String deliverypersonNumber;
  int status;
  int active;
  int createdBy;
  dynamic createdDate;
  int updatedBy;
  dynamic updatedDate;

  OrderDetailsList({
    required this.id,
    required this.orderid,
    required this.orderstatus,
    required this.pickupaddress,
    required this.deliveryaddress,
    required this.totalamount,
    required this.deliverypersonName,
    required this.deliverypersonNumber,
    required this.status,
    required this.active,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory OrderDetailsList.fromJson(Map<String, dynamic> json) =>
      OrderDetailsList(
        id: json["id"],
        orderid: json["orderid"],
        orderstatus: json["orderstatus"],
        pickupaddress: json["pickupaddress"],
        deliveryaddress: json["deliveryaddress"],
        totalamount: json["totalamount"],
        deliverypersonName: json["deliveryperson_name"],
        deliverypersonNumber: json["deliveryperson_number"],
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
        "orderstatus": orderstatus,
        "pickupaddress": pickupaddress,
        "deliveryaddress": deliveryaddress,
        "totalamount": totalamount,
        "deliveryperson_name": deliverypersonName,
        "deliveryperson_number": deliverypersonNumber,
        "status": status,
        "active": active,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}
