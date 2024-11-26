// To parse this JSON data, do
//
//     final dashboardlistmodel = dashboardlistmodelFromJson(jsonString);

import 'dart:convert';

import 'package:namstore/pages/admin_panel/pages/payments_page.dart';

IndividualorderdetailsModel individualorderdetailsmodelFromJson(String str) =>
    IndividualorderdetailsModel.fromJson(json.decode(str));

String individualorderdetailsmodelToJson(IndividualorderdetailsModel data) =>
    json.encode(data.toJson());

class IndividualorderdetailsModel {
  String status;
  List<Indivualoders> list;
  String code;
  String message;

  IndividualorderdetailsModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory IndividualorderdetailsModel.fromJson(Map<String, dynamic> json) =>
      IndividualorderdetailsModel(
        status: json["status"],
        list: List<Indivualoders>.from(
            json["list"].map((x) => Indivualoders.fromJson(x))),
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

class Indivualoders {
  int id;
  String orderid;
  String items;
  String date;
  List<Userdetails> userdetails;
  List<Storedetails> storedetails;
  List<Deliverydetails> deliverydetails;
  List<Orderdetails> orderdetails;
  List<Paymentdetails> paymentdetails;

  int status;
  int active;
  int createdBy;
  String? createdDate;
  int updatedBy;
  String? updatedDate;

  Indivualoders({
    required this.id,
    required this.orderid,
    required this.items,
    required this.date,
    required this.userdetails,
    required this.storedetails,
    required this.deliverydetails,
    required this.orderdetails,
    required this.paymentdetails,
    required this.status,
    required this.active,
    required this.createdBy,
    this.createdDate,
    required this.updatedBy,
    this.updatedDate,
  });

  factory Indivualoders.fromJson(Map<String, dynamic> json) => Indivualoders(
        id: json["id"],
        orderid: json["orderid"],
        items: json["items"],
        date: json["date"],
        userdetails: List<Userdetails>.from(
            json["userdetails"].map((x) => Userdetails.fromJson(x))),
        storedetails: List<Storedetails>.from(
            json["storedetails"].map((x) => Storedetails.fromJson(x))),
        deliverydetails: List<Deliverydetails>.from(
            json["deliverydetails"].map((x) => Deliverydetails.fromJson(x))),
        orderdetails: List<Orderdetails>.from(
            json["orderdetails"].map((x) => Orderdetails.fromJson(x))),
        paymentdetails: List<Paymentdetails>.from(
            json["paymentdetails"].map((x) => Paymentdetails.fromJson(x))),
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
        "date": date,
        "userdetails": List<dynamic>.from(userdetails.map((x) => x.toJson())),
        "storedetails": List<dynamic>.from(storedetails.map((x) => x.toJson())),
        "deliverydetails":
            List<dynamic>.from(deliverydetails.map((x) => x.toJson())),
        "orderdetails": List<dynamic>.from(orderdetails.map((x) => x.toJson())),
        "paymentdetails":
            List<dynamic>.from(paymentdetails.map((x) => x.toJson())),
        "status": status,
        "active": active,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}

// User details
class Userdetails {
  String? username;
  String? usermobilenumber;
  String? useraddress;

  Userdetails({
    this.username,
    this.usermobilenumber,
    this.useraddress,
  });

  factory Userdetails.fromJson(Map<String, dynamic> json) => Userdetails(
        username: json["username"],
        usermobilenumber: json["usermobilenumber"],
        useraddress: json["useraddress"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "usermobilenumber": usermobilenumber,
        "useraddress": useraddress,
      };
}

// Store details
class Storedetails {
  String? storename;
  String? storeownername;
  String? storemobilenumber;
  String? storeaddress;

  Storedetails({
    this.storename,
    this.storeownername,
    this.storemobilenumber,
    this.storeaddress,
  });

  factory Storedetails.fromJson(Map<String, dynamic> json) => Storedetails(
        storename: json["storename"],
        storeownername: json["storeownername"],
        storemobilenumber: json["storemobilenumber"],
        storeaddress: json["storeaddress"],
      );

  Map<String, dynamic> toJson() => {
        "storename": storename,
        "storeownername": storeownername,
        "storemobilenumber": storemobilenumber,
        "storeaddress": storeaddress,
      };
}

// Delivery details
class Deliverydetails {
  String? deliverypersonname;
  String? deliverypersonmobilenumber;
  String? deliveryaddress;

  Deliverydetails({
    this.deliverypersonname,
    this.deliverypersonmobilenumber,
    this.deliveryaddress,
  });

  factory Deliverydetails.fromJson(Map<String, dynamic> json) =>
      Deliverydetails(
        deliverypersonname: json["deliverypersonname"],
        deliverypersonmobilenumber: json["deliverypersonmobilenumber"],
        deliveryaddress: json["deliveryaddress"],
      );

  Map<String, dynamic> toJson() => {
        "deliverypersonname": deliverypersonname,
        "deliverypersonmobilenumber": deliverypersonmobilenumber,
        "deliveryaddress": deliveryaddress,
      };
}

// Order details
class Orderdetails {
  String? dishname;
  String? dishqty;
  String? singleprice;

  Orderdetails({
    this.dishname,
    this.dishqty,
    this.singleprice,
  });

  factory Orderdetails.fromJson(Map<String, dynamic> json) => Orderdetails(
        dishname: json["dishname"],
        dishqty: json["dishqty"]?.toString(),
        singleprice: json["singleprice"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "dishname": dishname,
        "dishqty": dishqty,
        "singleprice": singleprice,
      };
}

// Payment details
class Paymentdetails {
  String? itemtotal;
  String? deliverychargers;
  String? platformfee;
  String? restaurantcharges;
  String? totalamount;
  String? paymentmethod;

  Paymentdetails({
    this.itemtotal,
    this.deliverychargers,
    this.platformfee,
    this.restaurantcharges,
    this.totalamount,
    this.paymentmethod,
  });

  factory Paymentdetails.fromJson(Map<String, dynamic> json) => Paymentdetails(
        itemtotal: json["itemtotal"],
        deliverychargers: json["deliverychargers"],
        platformfee: json["platformfee"],
        restaurantcharges: json["restaurantcharges"],
        totalamount: json["totalamount"],
        paymentmethod: json["paymentmethod"],
      );

  Map<String, dynamic> toJson() => {
        "itemtotal": itemtotal,
        "deliverychargers": deliverychargers,
        "platformfee": platformfee,
        "restaurantcharges": restaurantcharges,
        "totalamount": totalamount,
        "paymentmethod": paymentmethod,
      };
}
