// To parse this JSON data, do
//
//     final registeredListmodel = registeredListmodelFromJson(jsonString);

import 'dart:convert';

RegisteredListmodel registeredListmodelFromJson(String str) =>
    RegisteredListmodel.fromJson(json.decode(str));

String registeredListmodelToJson(RegisteredListmodel data) =>
    json.encode(data.toJson());

class RegisteredListmodel {
  String status;
  List<RegisteredUser> list;
  String code;
  String message;

  RegisteredListmodel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory RegisteredListmodel.fromJson(Map<String, dynamic> json) =>
      RegisteredListmodel(
        status: json["status"],
        list: List<RegisteredUser>.from(
            json["list"].map((x) => RegisteredUser.fromJson(x))),
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

class RegisteredUser {
  int id;
  String? username;
  String? password;
  String? fullname;
  String? email;
  String? mobile;
  int role;
  String regOtp;
  int status;
  int active;
  int createdBy;
  DateTime createdDate;
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
  String? alternativeMobile;

  RegisteredUser({
    required this.id,
    this.username,
    this.password,
    this.fullname,
    this.email,
    this.mobile,
    required this.role,
    required this.regOtp,
    required this.status,
    required this.active,
    required this.createdBy,
    required this.createdDate,
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
    this.alternativeMobile,
  });

  factory RegisteredUser.fromJson(Map<String, dynamic> json) => RegisteredUser(
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
        alternativeMobile: json["alternative_mobile"],
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
        "created_date": createdDate.toIso8601String(),
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
        "alternative_mobile": alternativeMobile,
      };
}
