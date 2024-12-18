// To parse this JSON data, do
//
//     final getallDeliveryPersonmodel = getallDeliveryPersonmodelFromJson(jsonString);

import 'dart:convert';

GetallDeliveryPersonmodel getallDeliveryPersonmodelFromJson(String str) =>
    GetallDeliveryPersonmodel.fromJson(json.decode(str));

String getallDeliveryPersonmodelToJson(GetallDeliveryPersonmodel data) =>
    json.encode(data.toJson());

class GetallDeliveryPersonmodel {
  String status;
  List<ListDeliveryPerson> list;
  String code;
  String message;

  GetallDeliveryPersonmodel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory GetallDeliveryPersonmodel.fromJson(Map<String, dynamic> json) =>
      GetallDeliveryPersonmodel(
        status: json["status"],
        list: List<ListDeliveryPerson>.from(
            json["list"].map((x) => ListDeliveryPerson.fromJson(x))),
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

class ListDeliveryPerson {
  int? id;
  String? username;
  String? password;
  String? fullname;
  String? email;
  String? mobile;
  int? role;
  String? regOtp;
  int? status;
  int? active;
  int? createdBy;
  DateTime? createdDate;
  int? updatedBy;
  DateTime? updatedDate;
  String? mobilePushId;
  String? imageUrl;
  String? licenseNo;
  String? vehicleNo;
  String? vehicleName;
  String? licenseFrontImg;
  String? licenseBackImg;
  String? vehicleImg;
  String? address;
  String? area;
  String? city;
  String? pincode;

  ListDeliveryPerson({
    this.id,
    this.username,
    this.password,
    this.fullname,
    this.email,
    this.mobile,
    this.role,
    this.regOtp,
    this.status,
    this.active,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
    this.mobilePushId,
    this.imageUrl,
    this.licenseNo,
    this.vehicleNo,
    this.vehicleName,
    this.licenseFrontImg,
    this.licenseBackImg,
    this.vehicleImg,
    this.address,
    this.area,
    this.city,
    this.pincode,
  });

  factory ListDeliveryPerson.fromJson(Map<String, dynamic> json) =>
      ListDeliveryPerson(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        fullname: json["fullname"],
        email: json["email"],
        mobile: json["mobile"],
        role: json["role"],
        regOtp: json["reg_otp"],
        status: json["status"],
        active: json["active"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"] == null
            ? null
            : DateTime.parse(json["updated_date"]),
        mobilePushId: json["mobile_push_id"],
        imageUrl: json["image_url"],
        licenseNo: json["license_no"],
        vehicleNo: json["vehicle_no"],
        vehicleName: json["vehicle_name"],
        licenseFrontImg: json["license_front_img"],
        licenseBackImg: json["license_back_img"],
        vehicleImg: json["vehicle_img"],
        address: json["address"],
        area: json["area"],
        city: json["city"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "fullname": fullname,
        "email": email,
        "mobile": mobile,
        "role": role,
        "reg_otp": regOtp,
        "status": status,
        "active": active,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate?.toIso8601String(),
        "mobile_push_id": mobilePushId,
        "image_url": imageUrl,
        "license_no": licenseNo,
        "vehicle_no": vehicleNo,
        "vehicle_name": vehicleName,
        "license_front_img": licenseFrontImg,
        "license_back_img": licenseBackImg,
        "vehicle_img": vehicleImg,
        "address": address,
        "area": area,
        "city": city,
        "pincode": pincode,
      };
}
