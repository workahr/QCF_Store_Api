// To parse this JSON data, do
//
//     final myStoreDetailsmodel = myStoreDetailsmodelFromJson(jsonString);

import 'dart:convert';

MyStoreDetailsAdminmodel myStoreDetailsmodelFromJson(String str) =>
    MyStoreDetailsAdminmodel.fromJson(json.decode(str));

String myStoreDetailsmodelToJson(MyStoreDetailsAdminmodel data) =>
    json.encode(data.toJson());

class MyStoreDetailsAdminmodel {
  String status;
  StoreDetails list;
  String code;
  String message;

  MyStoreDetailsAdminmodel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory MyStoreDetailsAdminmodel.fromJson(Map<String, dynamic> json) =>
      MyStoreDetailsAdminmodel(
        status: json["status"],
        list: StoreDetails.fromJson(json["list"]),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "list": list.toJson(),
        "code": code,
        "message": message,
      };
}

class StoreDetails {
  int storeId;
  int userId;
  String? name;
  String? mobile;
  String? email;
  String? address;
  String? city;
  String? state;
  String? country;
  String? logo;
  String? gstNo;
  String? panNo;
  String? terms;
  String? zipcode;
  String? frontImg;
  String? onlineVisibility;
  String? tags;
  int status;
  int? createdBy;
  dynamic createdDate;
  int? updatedBy;
  dynamic updatedDate;
  String? slug;
  int? storeStatus;

  StoreDetails({
    required this.storeId,
    required this.userId,
    this.name,
    this.mobile,
    this.email,
    this.address,
    this.city,
    this.state,
    this.country,
    this.logo,
    this.gstNo,
    this.panNo,
    this.terms,
    this.zipcode,
    this.frontImg,
    this.onlineVisibility,
    this.tags,
    required this.status,
    this.createdBy,
    required this.createdDate,
    this.updatedBy,
    required this.updatedDate,
    this.slug,
    this.storeStatus,
  });

  factory StoreDetails.fromJson(Map<String, dynamic> json) => StoreDetails(
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
      );

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
      };
}
