// To parse this JSON data, do
//
//     final adminstorelistmodel = adminstorelistmodelFromJson(jsonString);

import 'dart:convert';

Adminstorelistmodel adminstorelistmodelFromJson(String str) =>
    Adminstorelistmodel.fromJson(json.decode(str));

String adminstorelistmodelToJson(Adminstorelistmodel data) =>
    json.encode(data.toJson());

class Adminstorelistmodel {
  String status;
  List<AdminStoreList> list;
  String code;
  String message;

  Adminstorelistmodel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory Adminstorelistmodel.fromJson(Map<String, dynamic> json) =>
      Adminstorelistmodel(
        status: json["status"],
        list: List<AdminStoreList>.from(
            json["list"].map((x) => AdminStoreList.fromJson(x))),
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

class AdminStoreList {
  int id;
  String image;
  String? storestatus;
  String? storename;
  String? storeAddress;
  String? storeOwnername;
  String? storeOwnernumber;
  int status;
  int active;
  int createdBy;
  dynamic createdDate;
  int updatedBy;
  dynamic updatedDate;
  String? orderid;
  String? orderstatus;
  String? pickupaddress;
  String? deliveryaddress;
  String? totalamount;
  String? deliverypersonName;
  String? deliverypersonNumber;

  AdminStoreList({
    required this.id,
    required this.image,
    this.storestatus,
    this.storename,
    this.storeAddress,
    this.storeOwnername,
    this.storeOwnernumber,
    required this.status,
    required this.active,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    this.orderid,
    this.orderstatus,
    this.pickupaddress,
    this.deliveryaddress,
    this.totalamount,
    this.deliverypersonName,
    this.deliverypersonNumber,
  });

  factory AdminStoreList.fromJson(Map<String, dynamic> json) => AdminStoreList(
        id: json["id"],
        image: json["image"],
        storestatus: json["storestatus"],
        storename: json["storename"],
        storeAddress: json["store_address"],
        storeOwnername: json["store_ownername"],
        storeOwnernumber: json["store_ownernumber"],
        status: json["status"],
        active: json["active"],
        createdBy: json["created_by"],
        createdDate: json["created_date"],
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
        orderid: json["orderid"],
        orderstatus: json["orderstatus"],
        pickupaddress: json["pickupaddress"],
        deliveryaddress: json["deliveryaddress"],
        totalamount: json["totalamount"],
        deliverypersonName: json["deliveryperson_name"],
        deliverypersonNumber: json["deliveryperson_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "storestatus": storestatus,
        "storename": storename,
        "store_address": storeAddress,
        "store_ownername": storeOwnername,
        "store_ownernumber": storeOwnernumber,
        "status": status,
        "active": active,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
        "orderid": orderid,
        "orderstatus": orderstatus,
        "pickupaddress": pickupaddress,
        "deliveryaddress": deliveryaddress,
        "totalamount": totalamount,
        "deliveryperson_name": deliverypersonName,
        "deliveryperson_number": deliverypersonNumber,
      };
}
