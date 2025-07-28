



// To parse this JSON data, do
//
//     final orderListmodel = orderListmodelFromJson(jsonString);

import 'dart:convert';

OrderListmodel orderListmodelFromJson(String str) =>
    OrderListmodel.fromJson(json.decode(str));

String orderListmodelToJson(OrderListmodel data) => json.encode(data.toJson());

class OrderListmodel {
  String status;
  List<OrderList> list;
  String code;
  String message;

  OrderListmodel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory OrderListmodel.fromJson(Map<String, dynamic> json) => OrderListmodel(
        status: json["status"],
        list: List<OrderList>.from(
            json["list"].map((x) => OrderList.fromJson(x))),
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

class OrderList {
  String? invoiceNumber;
  int? code;
  String? customercode;
  int? totalProduct;
  String? totalPrice;
  String? deliveryCharges;
  String? orderStatus;
  String? paymentMethod;
  int? prepareMin;
  DateTime? createdDate;
  int? userId;
  String? deliveryPartnerId;
  String? customerName;
  String? pickup_date;
  String? delivered_date;
  String? customerMobile;
  String? deliveryBoyName;
  String? deliveryBoyMobile;
  List<Item>? items;
  CustomerAddress? customerAddress;
  StoreAddress? storeAddress;

  OrderList({
    this.invoiceNumber,
    this.code,
    this.customercode,
    this.totalProduct,
    this.totalPrice,
    this.deliveryCharges,
    this.orderStatus,
    this.paymentMethod,
    this.prepareMin,
    this.createdDate,
    this.userId,
    this.deliveryPartnerId,
    this.customerName,
    this.pickup_date,
    this.delivered_date,
    this.customerMobile,
    this.deliveryBoyName,
    this.deliveryBoyMobile,
     this.items,
     this.customerAddress,
     this.storeAddress,
  });

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        invoiceNumber: json["invoice_number"],
        code: json["code"],
        customercode: json["customer_code"],
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
        pickup_date: json["pickup_date"],
        delivered_date: json["delivered_date"],
        customerMobile: json["customer_mobile"],
        deliveryBoyName: json["delivery_boy_name"],
        deliveryBoyMobile: json["delivery_boy_mobile"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        // customerAddress: CustomerAddress.fromJson(json["customer_address"]),
        customerAddress: (json["customer_address"] is List &&
                json["customer_address"].isEmpty)
            ? CustomerAddress() // Return an empty address object
            : CustomerAddress.fromJson(json["customer_address"]),
          //storeAddress: StoreAddress.fromJson(json["store_address"]),
          storeAddress: (json["store_address"] is List &&
                json["store_address"].isEmpty)
            ? StoreAddress() // Return an empty address object
            : StoreAddress.fromJson(json["store_address"]),
      );

  Map<String, dynamic> toJson() => {
        "invoice_number": invoiceNumber,
        "code": code,
        "customer_code": customercode,
        "total_product": totalProduct,
        "total_price": totalPrice,
        "delivery_charges": deliveryCharges,
        "order_status": orderStatus,
        "payment_method": paymentMethod,
        "prepare_min": prepareMin,
        "created_date": createdDate!.toIso8601String(),
        "user_id": userId,
        "delivery_partner_id": deliveryPartnerId,
        "customer_name": customerName,
        "pickup_date": pickup_date,
        "delivered_date": delivered_date,
        "customer_mobile": customerMobile,
        "delivery_boy_name": deliveryBoyName,
        "delivery_boy_mobile": deliveryBoyMobile,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
         "customer_address": customerAddress!.toJson(),
        "store_address": storeAddress!.toJson(),
      };
}

class CustomerAddress {
  int? id;
  int? orderId;
  String? address;
  String? landmark;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? main_location;
  String? sub_location;
  String? addressLine2;
  int? status;
  DateTime? createdDate;

  CustomerAddress({
    this.id,
    this.orderId,
    this.address,
    this.landmark,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.addressLine2,
    this.main_location,
    this.sub_location,
    this.status,
    this.createdDate,
  });

  factory CustomerAddress.fromJson(Map<String, dynamic> json) =>
      CustomerAddress(
        id: json["id"],
        orderId: json["order_id"],
        address: json["address"],
        landmark: json["landmark"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        pincode: json["pincode"],
        main_location: json["main_location"],
        sub_location: json["sub_location"],
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
        "main_location": main_location,
        "sub_location": sub_location,
        "address_line_2": addressLine2,
        "status": status,
        "created_date": createdDate!.toIso8601String(),
      };
}

class Item {
  int? orderItemId;
  int? storeId;
  int? orderId;
  int? productId;
  String? productName;
  int? userId;
  String? price;
  int? quantity;
  String? totalPrice;
  String? storePrice;
  String? storeTotalPrice;
  String? imageUrl;
  int? status;
  int? createdBy;
  DateTime? createdDate;
  String? updatedBy;
  String? updatedDate;

  Item({
    this.orderItemId,
    this.storeId,
    this.orderId,
    this.productId,
    this.productName,
    this.userId,
    this.price,
    this.quantity,
    this.totalPrice,
    this.storePrice,
    this.storeTotalPrice,
    this.imageUrl,
    this.status,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
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
        imageUrl: json["image_url"],
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
        "image_url": imageUrl,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate!.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}

class StoreAddress {
  int? storeId;
  int? userId;
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
  int? status;
  int? createdBy;
  DateTime? createdDate;
  int? updatedBy;
  DateTime? updatedDate;
  String? slug;
  int? storeStatus;
  String? ownerName;

  StoreAddress({
    this.storeId,
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
    this.status,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
    this.slug,
    this.storeStatus,
    this.ownerName,
  });

  factory StoreAddress.fromJson(Map<String, dynamic> json) => StoreAddress(
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
        ownerName: json["owner_name"],
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
        "owner_name": ownerName,
      };
}












// // To parse this JSON data, do
// //
// //     final orderListmodel = orderListmodelFromJson(jsonString);

// import 'dart:convert';

// OrderListmodel orderListmodelFromJson(String str) => OrderListmodel.fromJson(json.decode(str));

// String orderListmodelToJson(OrderListmodel data) => json.encode(data.toJson());

// class OrderListmodel {
//     String? status;
//     List<OrderList>? list;
//     String? code;
//     String? message;

//     OrderListmodel({
//         this.status,
//         this.list,
//         this.code,
//         this.message,
//     });

//     factory OrderListmodel.fromJson(Map<String, dynamic> json) => OrderListmodel(
//         status: json["status"],
//         list: List<OrderList>.from(json["list"].map((x) => OrderList.fromJson(x))),
//         code: json["code"],
//         message: json["message"],
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "list": List<dynamic>.from(list!.map((x) => x.toJson())),
//         "code": code,
//         "message": message,
//     };
// }

// class OrderList {
//     String? invoiceNumber;
//     int? code;
//     int? totalProduct;
//     String? totalPrice;
//     String? deliveryCharges;
//     String? orderStatus;
//     String? paymentMethod;
//     int? prepareMin;
//     DateTime? createdDate;
//     DateTime? pickupDate;
//     DateTime? deliveredDate;
//     int? userId;
//     String? deliveryPartnerId;
//     String? customerName;
//     String? customerMobile;
//     String? deliveryBoyName;
//     String? deliveryBoyMobile;
//     List<Item>? items;
//     String? customerAddress;
//     String? storeAddress;

//     OrderList({
//         this.invoiceNumber,
//         this.code,
//         this.totalProduct,
//         this.totalPrice,
//         this.deliveryCharges,
//         this.orderStatus,
//         this.paymentMethod,
//         this.prepareMin,
//         this.createdDate,
//         this.pickupDate,
//         this.deliveredDate,
//         this.userId,
//         this.deliveryPartnerId,
//         this.customerName,
//         this.customerMobile,
//         this.deliveryBoyName,
//         this.deliveryBoyMobile,
//         this.items,
//         this.customerAddress,
//         this.storeAddress,
//     });

//     factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
//         invoiceNumber: json["invoice_number"],
//         code: json["code"],
//         totalProduct: json["total_product"],
//         totalPrice: json["total_price"],
//         deliveryCharges: json["delivery_charges"],
//         orderStatus: json["order_status"],
//         paymentMethod: json["payment_method"],
//         prepareMin: json["prepare_min"],
//         createdDate: DateTime.parse(json["created_date"]),
//         pickupDate: json["pickup_date"],
//         deliveredDate: json["delivered_date"],
//         userId: json["user_id"],
//         deliveryPartnerId: json["delivery_partner_id"],
//         customerName: json["customer_name"],
//         customerMobile: json["customer_mobile"],
//         deliveryBoyName: json["delivery_boy_name"],
//         deliveryBoyMobile: json["delivery_boy_mobile"],
//         items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
//         customerAddress: json["customer_address"],
//         storeAddress: json["store_address"],
//     );

//     Map<String, dynamic> toJson() => {
//         "invoice_number": invoiceNumber,
//         "code": code,
//         "total_product": totalProduct,
//         "total_price": totalPrice,
//         "delivery_charges": deliveryCharges,
//         "order_status": orderStatus,
//         "payment_method": paymentMethod,
//         "prepare_min": prepareMin,
//         "created_date": createdDate!.toIso8601String(),
//         "pickup_date": pickupDate,
//         "delivered_date": deliveredDate,
//         "user_id": userId,
//         "delivery_partner_id": deliveryPartnerId,
//         "customer_name": customerName,
//         "customer_mobile": customerMobile,
//         "delivery_boy_name": deliveryBoyName,
//         "delivery_boy_mobile": deliveryBoyMobile,
//         "items": List<dynamic>.from(items!.map((x) => x.toJson())),
//         "customer_address": customerAddress,
//         "store_address": storeAddress,
//     };
// }

// class CustomerAddressClass {
//     int? id;
//     int? orderId;
//     String? address;
//     String? landmark;
//     String? city;
//     String? state;
//     String? country;
//     String? pincode;
//     String? addressLine2;
//     String? mainLocation;
//     String? subLocation;
//     String? latitude;
//     String? longitude;
//     String? fullname;
//     String? mobile;
//     String? email;
//     int? status;
//     DateTime? createdDate;

//     CustomerAddressClass({
//         this.id,
//         this.orderId,
//         this.address,
//         this.landmark,
//         this.city,
//         this.state,
//         this.country,
//         this.pincode,
//         this.addressLine2,
//         this.mainLocation,
//         this.subLocation,
//         this.latitude,
//         this.longitude,
//         this.fullname,
//         this.mobile,
//         this.email,
//         this.status,
//         this.createdDate,
//     });

//     factory CustomerAddressClass.fromJson(Map<String, dynamic> json) => CustomerAddressClass(
//         id: json["id"],
//         orderId: json["order_id"],
//         address: json["address"],
//         landmark: json["landmark"],
//         city: json["city"],
//         state: json["state"],
//         country: json["country"],
//         pincode: json["pincode"],
//         addressLine2: json["address_line_2"],
//         mainLocation: json["main_location"],
//         subLocation: json["sub_location"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//         fullname: json["fullname"],
//         mobile: json["mobile"],
//         email: json["email"],
//         status: json["status"],
//         createdDate: DateTime.parse(json["created_date"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "order_id": orderId,
//         "address": address,
//         "landmark": landmark,
//         "city": city,
//         "state": state,
//         "country": country,
//         "pincode": pincode,
//         "address_line_2": addressLine2,
//         "main_location":mainLocation,
//         "sub_location": subLocation,
//         "latitude": latitude,
//         "longitude": longitude,
//         "fullname": fullname,
//         "mobile": mobile,
//         "email": email,
//         "status": status,
//         "created_date": createdDate!.toIso8601String(),
//     };
// }


// class Item {
//     int? orderItemId;
//     int? storeId;
//     int? orderId;
//     int? productId;
//     String? productName;
//     int? userId;
//     String? price;
//     int? quantity;
//     String? totalPrice;
//     String? storePrice;
//     String? storeTotalPrice;
//     String? imageUrl;
//     int? status;
//     int? createdBy;
//     DateTime? createdDate;
//     int? updatedBy;
//     DateTime? updatedDate;

//     Item({
//         this.orderItemId,
//         this.storeId,
//         this.orderId,
//         this.productId,
//         this.productName,
//         this.userId,
//         this.price,
//         this.quantity,
//         this.totalPrice,
//         this.storePrice,
//         this.storeTotalPrice,
//         this.imageUrl,
//         this.status,
//         this.createdBy,
//         this.createdDate,
//         this.updatedBy,
//         this.updatedDate,
//     });

//     factory Item.fromJson(Map<String, dynamic> json) => Item(
//         orderItemId: json["order_item_id"],
//         storeId: json["store_id"],
//         orderId: json["order_id"],
//         productId: json["product_id"],
//         productName: json["product_name"],
//         userId: json["user_id"],
//         price: json["price"],
//         quantity: json["quantity"],
//         totalPrice: json["total_price"],
//         storePrice: json["store_price"],
//         storeTotalPrice: json["store_total_price"],
//         imageUrl: json["image_url"],
//         status: json["status"],
//         createdBy: json["created_by"],
//         createdDate: DateTime.parse(json["created_date"]),
//         updatedBy: json["updated_by"],
//         updatedDate: json["updated_date"],
//     );

//     Map<String, dynamic> toJson() => {
//         "order_item_id": orderItemId,
//         "store_id": storeId,
//         "order_id": orderId,
//         "product_id": productId,
//         "product_name": productName,
//         "user_id": userId,
//         "price": price,
//         "quantity": quantity,
//         "total_price": totalPrice,
//         "store_price": storePrice,
//         "store_total_price": storeTotalPrice,
//         "image_url": imageUrl,
//         "status": status,
//         "created_by": createdBy,
//         "created_date": createdDate!.toIso8601String(),
//         "updated_by": updatedBy,
//         "updated_date": updatedDate,
//     };
// }





// class StoreAddressClass {
//     int? storeId;
//     int? userId;
//     String? name;
//     String? mobile;
//     String? alternativeMobile;
//     String? email;
//     String? address;
//     String? city;
//     String? state;
//     String? country;
//     String? logo;
//     String? gstNo;
//     String? panNo;
//     String? terms;
//     String? zipcode;
//     String? frontImg;
//     String? onlineVisibility;
//     String? tags;
//     String? metaTitle;
//     String? metaDescription;
//     String? metaKeywords;
//     int? status;
//     int? createdBy;
//     DateTime? createdDate;
//     int? updatedBy;
//     DateTime? updatedDate;
//     String? slug;
//     int? storeStatus;
//     String? latitude;
//     String? longitude;
//     String? minimumOrderAmount;
//     int? basePricePercent;
//     int? stickPricePercent;
//     String? perKmCharge;
//     String? defaultDeliveryCharge;
//     String? aboutUs;
//     String? contactUs;
//     String? privacyPolicy;
//     String? termsCondition;
//     String? ownerName;

//     StoreAddressClass({
//         this.storeId,
//         this.userId,
//         this.name,
//         this.mobile,
//         this.alternativeMobile,
//         this.email,
//         this.address,
//         this.city,
//         this.state,
//         this.country,
//         this.logo,
//         this.gstNo,
//         this.panNo,
//         this.terms,
//         this.zipcode,
//         this.frontImg,
//         this.onlineVisibility,
//         this.tags,
//         this.metaTitle,
//         this.metaDescription,
//         this.metaKeywords,
//         this.status,
//         this.createdBy,
//         this.createdDate,
//         this.updatedBy,
//         this.updatedDate,
//         this.slug,
//         this.storeStatus,
//         this.latitude,
//         this.longitude,
//         this.minimumOrderAmount,
//         this.basePricePercent,
//         this.stickPricePercent,
//         this.perKmCharge,
//         this.defaultDeliveryCharge,
//         this.aboutUs,
//         this.contactUs,
//         this.privacyPolicy,
//         this.termsCondition,
//         this.ownerName,
//     });

//     factory StoreAddressClass.fromJson(Map<String, dynamic> json) => StoreAddressClass(
//         storeId: json["store_id"],
//         userId: json["user_id"],
//         name: json["name"],
//         mobile: json["mobile"],
//         alternativeMobile: json["alternative_mobile"],
//         email:json["email"],
//         address: json["address"],
//         city: json["city"],
//         state: json["state"],
//         country:json["country"],
//         logo: json["logo"],
//         gstNo: json["gst_no"],
//         panNo: json["pan_no"],
//         terms: json["terms"],
//         zipcode: json["zipcode"],
//         frontImg: json["front_img"],
//         onlineVisibility: json["online_visibility"],
//         tags: json["tags"],
//         metaTitle: json["meta_title"],
//         metaDescription: json["meta_description"],
//         metaKeywords: json["meta_keywords"],
//         status: json["status"],
//         createdBy: json["created_by"],
//         createdDate: json["created_date"],
//         updatedBy: json["updated_by"],
//         updatedDate: DateTime.parse(json["updated_date"]),
//         slug: json["slug"],
//         storeStatus: json["store_status"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//         minimumOrderAmount: json["minimum_order_amount"],
//         basePricePercent: json["base_price_percent"],
//         stickPricePercent: json["stick_price_percent"],
//         perKmCharge: json["per_km_charge"],
//         defaultDeliveryCharge: json["default_delivery_charge"],
//         aboutUs: json["about_us"],
//         contactUs: json["contact_us"],
//         privacyPolicy: json["privacy_policy"],
//         termsCondition: json["terms_condition"],
//         ownerName:json["owner_name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "store_id": storeId,
//         "user_id": userId,
//         "name": name,
//         "mobile": mobile,
//         "alternative_mobile": alternativeMobile,
//         "email":email,
//         "address": address,
//         "city": city,
//         "state": state,
//         "country":country,
//         "logo": logo,
//         "gst_no": gstNo,
//         "pan_no": panNo,
//         "terms": terms,
//         "zipcode": zipcode,
//         "front_img": frontImg,
//         "online_visibility": onlineVisibility,
//         "tags": tags,
//         "meta_title": metaTitle,
//         "meta_description": metaDescription,
//         "meta_keywords": metaKeywords,
//         "status": status,
//         "created_by": createdBy,
//         "created_date": createdDate,
//         "updated_by": updatedBy,
//         "updated_date": updatedDate!.toIso8601String(),
//         "slug": slug,
//         "store_status": storeStatus,
//         "latitude": latitude,
//         "longitude": longitude,
//         "minimum_order_amount": minimumOrderAmount,
//         "base_price_percent": basePricePercent,
//         "stick_price_percent": stickPricePercent,
//         "per_km_charge": perKmCharge,
//         "default_delivery_charge": defaultDeliveryCharge,
//         "about_us": aboutUs,
//         "contact_us": contactUs,
//         "privacy_policy": privacyPolicy,
//         "terms_condition": termsCondition,
//         "owner_name": ownerName,
//     };
// }

















