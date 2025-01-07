import 'dart:convert';

StoreEditmodel getStorebyidmodelFromJson(String str) =>
    StoreEditmodel.fromJson(json.decode(str));

String getStorebyidmodelToJson(StoreEditmodel data) =>
    json.encode(data.toJson());

class StoreEditmodel {
  String status;
  ListStore list;
  String code;
  List<ProductList> productList;
  UserList userList;
  String message;

  StoreEditmodel({
    required this.status,
    required this.list,
    required this.code,
    required this.productList,
    required this.userList,
    required this.message,
  });

  factory StoreEditmodel.fromJson(Map<String, dynamic> json) => StoreEditmodel(
        status: json["status"] ?? "",
        list: ListStore.fromJson(json["list"] ?? {}),
        code: json["code"] ?? "",
        productList: json["product_list"] == null
            ? []
            : List<ProductList>.from(
                json["product_list"].map((x) => ProductList.fromJson(x))),
        userList: UserList.fromJson(json["user_list"] ?? {}),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "list": list.toJson(),
        "code": code,
        "product_list": List<dynamic>.from(productList.map((x) => x.toJson())),
        "user_list": userList.toJson(),
        "message": message,
      };
}

class ListStore {
  int storeId;
  int userId;
  String? name;
  String? mobile;
  String? alternative_mobile;
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
  String? createdDate;
  int? updatedBy;
  String? updatedDate;
  String? slug;
  int storeStatus;
  String? minimum_order_amount;

  ListStore({
    required this.storeId,
    required this.userId,
    this.name,
    this.mobile,
    this.alternative_mobile,
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
    required this.storeStatus,
    this.minimum_order_amount,
  });

  factory ListStore.fromJson(Map<String, dynamic> json) => ListStore(
        storeId: json["store_id"] ?? 0,
        userId: json["user_id"] ?? 0,
        name: json["name"],
        mobile: json["mobile"],
        alternative_mobile: json["alternative_mobile"],
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
        status: json["status"] ?? 0,
        createdBy: json["created_by"],
        createdDate: json["created_date"],
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
        slug: json["slug"],
        storeStatus: json["store_status"] ?? 0,
        minimum_order_amount: json["minimum_order_amount"],
      );

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "user_id": userId,
        "name": name,
        "mobile": mobile,
        "alternative_mobile": alternative_mobile,
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
        "minimum_order_amount": minimum_order_amount,
      };
}

class ProductList {
  // Placeholder for ProductList. Add fields and implementation as needed.
  ProductList();

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList();

  Map<String, dynamic> toJson() => {};
}

class UserList {
  int id;
  String? username;
  String? password;
  String? fullname;
  String? email;
  String? mobile;
  int role;
  String? regOtp;
  int status;
  int active;
  int? createdBy;
  String? createdDate;
  int? updatedBy;
  String? updatedDate;
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

  UserList({
    required this.id,
    this.username,
    this.password,
    this.fullname,
    this.email,
    this.mobile,
    required this.role,
    this.regOtp,
    required this.status,
    required this.active,
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

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        id: json["id"] ?? 0,
        username: json["username"],
        password: json["password"],
        fullname: json["fullname"],
        email: json["email"],
        mobile: json["mobile"],
        role: json["role"] ?? 0,
        regOtp: json["reg_otp"],
        status: json["status"] ?? 0,
        active: json["active"] ?? 0,
        createdBy: json["created_by"],
        createdDate: json["created_date"],
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
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
        "updated_date": updatedDate,
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

void main() {
  // Example usage:
  final jsonString = '''{
    "status": "SUCCESS",
    "list": {
        "store_id": 4,
        "user_id": 70,
        "name": "Sasi Hotel",
        "mobile": "9087456321",
        "email": "sasi@gmail.com",
        "address": "trichy",
        "city": "trichy",
        "state": "Tamil Nadu",
        "country": "0",
        "logo": null,
        "gst_no": "hdf367i",
        "pan_no": "ghxf5783",
        "terms": null,
        "zipcode": "1357",
        "front_img": "cdn/store/m/4/534ffd169b601681f4429a609f57e711.jpg",
        "online_visibility": "Yes",
        "tags": "store1",
        "status": 1,
        "created_by": 3,
        "created_date": "2024-12-02 05:37:54",
        "updated_by": null,
        "updated_date": null,
        "slug": null,
        "store_status": 1
    },
    "code": "206",
    "product_list": [],
    "user_list": {
        "id": 70,
        "username": "sasi",
        "password": "sasi",
        "fullname": "Sasi",
        "email": "sasi@gmail.com",
        "mobile": "9087456321",
        "role": 4,
        "reg_otp": null,
        "status": 1,
        "active": 1,
        "created_by": 3,
        "created_date": "2024-12-02 05:37:54",
        "updated_by": null,
        "updated_date": null,
        "mobile_push_id": null,
        "image_url": "cdn/profile/m/70/374bd662b6a71c093b1ef1f410a6c3dc.jpg",
        "license_no": null,
        "vehicle_no": null,
        "vehicle_name": null,
        "license_front_img": null,
        "license_back_img": null,
        "vehicle_img": null,
        "address": null,
        "area": null,
        "city": null,
        "pincode": null
    },
    "message": "Listed Succesfully."
  }''';

  final decoded = json.decode(jsonString);
  final model = StoreEditmodel.fromJson(decoded);

  print(model.toJson());
}
