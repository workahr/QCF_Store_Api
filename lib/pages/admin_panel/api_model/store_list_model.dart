// To parse this JSON data, do
//
//     final StoreListDatamodel = StoreListDatamodelFromJson(jsonString);

import 'dart:convert';

StoreListmodel storeListmodelFromJson(String str) =>
    StoreListmodel.fromJson(json.decode(str));

String storeListmodelToJson(StoreListmodel data) => json.encode(data.toJson());

class StoreListmodel {
  String status;
  List<StoreListData> list;
  String code;
  String message;

  StoreListmodel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory StoreListmodel.fromJson(Map<String, dynamic> json) => StoreListmodel(
        status: json["status"],
        list: List<StoreListData>.from(
            json["list"].map((x) => StoreListData.fromJson(x))),
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

class StoreListData {
  int storeId;
  int userId;
  String name;
  String mobile;
  String email;
  String address;
  String city;
  String state;
  dynamic country;
  dynamic logo;
  dynamic gstNo;
  dynamic panNo;
  dynamic terms;
  String zipcode;
  dynamic frontImg;
  String onlineVisibility;
  dynamic tags;
  int status;
  dynamic createdBy;
  dynamic createdDate;
  dynamic updatedBy;
  dynamic updatedDate;
  dynamic slug;
  int storeStatus;
  String? owner_name;

  StoreListData({
    required this.storeId,
    required this.userId,
    required this.name,
    required this.mobile,
    required this.email,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.logo,
    required this.gstNo,
    required this.panNo,
    required this.terms,
    required this.zipcode,
    required this.frontImg,
    required this.onlineVisibility,
    required this.tags,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.slug,
    required this.storeStatus,
    this.owner_name,
  });

  factory StoreListData.fromJson(Map<String, dynamic> json) => StoreListData(
      storeId: json["store_id"],
      userId: json["user_id"],
      name: json["name"],
      mobile: json["mobile"],
      email: json["email"],
      address: json["address"],
      city: json["city"],
      state: json["state"],
      country: json["country"],
      logo: json["logo"],
      gstNo: json["gst_no"],
      panNo: json["pan_no"],
      terms: json["terms"],
      zipcode: json["zipcode"],
      frontImg: json["front_img"],
      onlineVisibility: json["online_visibility"],
      tags: json["tags"],
      status: json["status"],
      createdBy: json["created_by"],
      createdDate: json["created_date"],
      updatedBy: json["updated_by"],
      updatedDate: json["updated_date"],
      slug: json["slug"],
      storeStatus: json["store_status"],
      owner_name: json["owner_name"]);

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "user_id": userId,
        "name": name,
        "mobile": mobile,
        "email": email,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "logo": logo,
        "gst_no": gstNo,
        "pan_no": panNo,
        "terms": terms,
        "zipcode": zipcode,
        "front_img": frontImg,
        "online_visibility": onlineVisibility,
        "tags": tags,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
        "slug": slug,
        "store_status": storeStatus,
        "owner_name": owner_name,
      };
}
