// To parse this JSON data, do
//
//     final unAssignDeliveryBoymodel = unAssignDeliveryBoymodelFromJson(jsonString);

import 'dart:convert';

UnAssignDeliveryBoymodel unAssignDeliveryBoymodelFromJson(String str) =>
    UnAssignDeliveryBoymodel.fromJson(json.decode(str));

String unAssignDeliveryBoymodelToJson(UnAssignDeliveryBoymodel data) =>
    json.encode(data.toJson());

class UnAssignDeliveryBoymodel {
  String status;
  List<UnAssignOrderList> list;
  String code;
  String message;

  UnAssignDeliveryBoymodel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory UnAssignDeliveryBoymodel.fromJson(Map<String, dynamic> json) =>
      UnAssignDeliveryBoymodel(
        status: json["status"],
        list: List<UnAssignOrderList>.from(
            json["list"].map((x) => UnAssignOrderList.fromJson(x))),
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

class UnAssignOrderList {
  String invoiceNumber;
  int code;
  int totalProduct;
  String totalPrice;
  String deliveryCharges;
  String orderStatus;
  String paymentMethod;
  int prepareMin;
  DateTime createdDate;
  int userId;
  String deliveryPartnerId;
  String customerName;
  String customerMobile;
  dynamic deliveryBoyName;
  dynamic deliveryBoyMobile;
  List<Item> items;
  UnCustomerAddress uncustomerAddress;
  unStoreAddress unstoreAddress;

  UnAssignOrderList({
    required this.invoiceNumber,
    required this.code,
    required this.totalProduct,
    required this.totalPrice,
    required this.deliveryCharges,
    required this.orderStatus,
    required this.paymentMethod,
    required this.prepareMin,
    required this.createdDate,
    required this.userId,
    required this.deliveryPartnerId,
    required this.customerName,
    required this.customerMobile,
    required this.deliveryBoyName,
    required this.deliveryBoyMobile,
    required this.items,
    required this.uncustomerAddress,
    required this.unstoreAddress,
  });

  factory UnAssignOrderList.fromJson(Map<String, dynamic> json) =>
      UnAssignOrderList(
        invoiceNumber: json["invoice_number"],
        code: json["code"],
        totalProduct: json["total_product"],
        totalPrice: json["total_price"],
        deliveryCharges: json["delivery_charges"],
        orderStatus: json["order_status"],
        paymentMethod: json["payment_method"],
        prepareMin: json["prepare_min"],
        createdDate: DateTime.parse(json["created_date"]),
        userId: json["user_id"],
        deliveryPartnerId: json["delivery_partner_id"],
        customerName: json["customer_name"],
        customerMobile: json["customer_mobile"],
        deliveryBoyName: json["delivery_boy_name"],
        deliveryBoyMobile: json["delivery_boy_mobile"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        uncustomerAddress:
            UnCustomerAddress.fromJson(json["uncustomer_address"]),
        unstoreAddress: unStoreAddress.fromJson(json["store_address"]),
      );

  Map<String, dynamic> toJson() => {
        "invoice_number": invoiceNumber,
        "code": code,
        "total_product": totalProduct,
        "total_price": totalPrice,
        "delivery_charges": deliveryCharges,
        "order_status": orderStatus,
        "payment_method": paymentMethod,
        "prepare_min": prepareMin,
        "created_date": createdDate.toIso8601String(),
        "user_id": userId,
        "delivery_partner_id": deliveryPartnerId,
        "customer_name": customerName,
        "customer_mobile": customerMobile,
        "delivery_boy_name": deliveryBoyName,
        "delivery_boy_mobile": deliveryBoyMobile,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "uncustomer_address": uncustomerAddress.toJson(),
        "unstore_address": unstoreAddress.toJson(),
      };
}

class UnCustomerAddress {
  int id;
  int orderId;
  String address;
  String landmark;
  String city;
  String state;
  String country;
  String pincode;
  String addressLine2;
  int status;
  DateTime createdDate;

  UnCustomerAddress({
    required this.id,
    required this.orderId,
    required this.address,
    required this.landmark,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
    required this.addressLine2,
    required this.status,
    required this.createdDate,
  });

  factory UnCustomerAddress.fromJson(Map<String, dynamic> json) =>
      UnCustomerAddress(
        id: json["id"],
        orderId: json["order_id"],
        address: json["address"],
        landmark: json["landmark"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        pincode: json["pincode"],
        addressLine2: json["address_line_2"],
        status: json["status"],
        createdDate: DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "address": address,
        "landmark": landmark,
        "city": city,
        "state": state,
        "country": country,
        "pincode": pincode,
        "address_line_2": addressLine2,
        "status": status,
        "created_date": createdDate.toIso8601String(),
      };
}

class Item {
  int orderItemId;
  int storeId;
  int orderId;
  int productId;
  String productName;
  int userId;
  String price;
  int quantity;
  String totalPrice;
  String storePrice;
  String storeTotalPrice;
  ImageUrl? imageUrl;
  int status;
  int createdBy;
  DateTime createdDate;
  dynamic updatedBy;
  dynamic updatedDate;

  Item({
    required this.orderItemId,
    required this.storeId,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.userId,
    required this.price,
    required this.quantity,
    required this.totalPrice,
    required this.storePrice,
    required this.storeTotalPrice,
    required this.imageUrl,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        orderItemId: json["order_item_id"],
        storeId: json["store_id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        userId: json["user_id"],
        price: json["price"],
        quantity: json["quantity"],
        totalPrice: json["total_price"],
        storePrice: json["store_price"],
        storeTotalPrice: json["store_total_price"],
        imageUrl: imageUrlValues.map[json["image_url"]]!,
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
      );

  Map<String, dynamic> toJson() => {
        "order_item_id": orderItemId,
        "store_id": storeId,
        "order_id": orderId,
        "product_id": productId,
        "product_name": productName,
        "user_id": userId,
        "price": price,
        "quantity": quantity,
        "total_price": totalPrice,
        "store_price": storePrice,
        "store_total_price": storeTotalPrice,
        "image_url": imageUrlValues.reverse[imageUrl],
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}

enum ImageUrl {
  CDN_ITEM_M_18_EE1_AF83_C007_D410_AA716115_A088_B1_CD_JPG,
  CDN_ITEM_M_35_B872_F05_E2_C6996_C1905_E5_FBF850_AA37_JPG
}

final imageUrlValues = EnumValues({
  "cdn/item/m/1/8ee1af83c007d410aa716115a088b1cd.jpg":
      ImageUrl.CDN_ITEM_M_18_EE1_AF83_C007_D410_AA716115_A088_B1_CD_JPG,
  "cdn/item/m/3/5b872f05e2c6996c1905e5fbf850aa37.jpg":
      ImageUrl.CDN_ITEM_M_35_B872_F05_E2_C6996_C1905_E5_FBF850_AA37_JPG
});

class unStoreAddress {
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

  unStoreAddress({
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
  });

  factory unStoreAddress.fromJson(Map<String, dynamic> json) => unStoreAddress(
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
