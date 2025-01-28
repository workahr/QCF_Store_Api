// To parse this JSON data, do
//
//     final myStoreDetailsmodel = myStoreDetailsmodelFromJson(jsonString);

import 'dart:convert';

MyStoreDetailsmodel myStoreDetailsmodelFromJson(String str) =>
    MyStoreDetailsmodel.fromJson(json.decode(str));

String myStoreDetailsmodelToJson(MyStoreDetailsmodel data) =>
    json.encode(data.toJson());

class MyStoreDetailsmodel {
  String status;
  StoreDetails list;
  String code;
  String message;

  MyStoreDetailsmodel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory MyStoreDetailsmodel.fromJson(Map<String, dynamic> json) =>
      MyStoreDetailsmodel(
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
  int? userId;
  String? name;
  String? mobile;
  String? email;
  String? address;
  String? city;
  String? state;
  String? country;
  String? logo; // Make nullable
  String? gstNo;
  String? panNo;
  String? terms; // Make nullable
  String? zipcode;
  String? frontImg;
  String? onlineVisibility;
  String? tags;
  int status;
  int? createdBy;
  DateTime? createdDate;
  int? updatedBy;
  DateTime? updatedDate;
  String? slug; // Make nullable
  int? storeStatus;
  int? base_price_percent;
  int? stick_price_percent;

  StoreDetails({
    required this.storeId,
    this.userId,
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
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
    this.slug,
    this.storeStatus,
    this.base_price_percent,
    this.stick_price_percent,
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
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"] == null
            ? null
            : DateTime.parse(json["updated_date"]),
        slug: json["slug"],
        storeStatus: json["store_status"],
        base_price_percent: json["base_price_percent"],
        stick_price_percent: json["stick_price_percent"],
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
        "created_date": createdDate?.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate?.toIso8601String(),
        "slug": slug,
        "store_status": storeStatus,
        "base_price_percent": base_price_percent,
        "stick_price_percent": stick_price_percent,
      };
}
