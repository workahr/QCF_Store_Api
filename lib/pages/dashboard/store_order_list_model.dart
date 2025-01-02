// To parse this JSON data, do
//
//     final storeOrderListModel = storeOrderListModelFromJson(jsonString);

import 'dart:convert';

StoreOrderListModel storeOrderListModelFromJson(String str) =>
    StoreOrderListModel.fromJson(json.decode(str));

String storeOrderListModelToJson(StoreOrderListModel data) =>
    json.encode(data.toJson());

class StoreOrderListModel {
  String status;
  List<StoreOrderListData> list;
  String code;
  String message;

  StoreOrderListModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory StoreOrderListModel.fromJson(Map<String, dynamic> json) =>
      StoreOrderListModel(
        status: json["status"],
        list: List<StoreOrderListData>.from(
            json["list"].map((x) => StoreOrderListData.fromJson(x))),
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

class StoreOrderListData {
  String invoiceNumber;
  int? code;
  int? totalProduct;
  String? totalPrice;
  String? deliveryCharges;
  String? orderStatus;
  String? paymentMethod;
  int? prepareMin;
  DateTime createdDate;
  int? userId;
  String? deliveryPartnerId;
  String? customerName;
  String? customerMobile;
  String? deliveryBoyName;
  String? deliveryBoyMobile;
  List<OrderItems> items;

  StoreOrderListData({
    required this.invoiceNumber,
    this.code,
    this.totalProduct,
    this.totalPrice,
    this.deliveryCharges,
    this.orderStatus,
    this.paymentMethod,
    this.prepareMin,
    required this.createdDate,
    this.userId,
    this.deliveryPartnerId,
    this.customerName,
    this.customerMobile,
    this.deliveryBoyName,
    this.deliveryBoyMobile,
    required this.items,
  });

  factory StoreOrderListData.fromJson(Map<String, dynamic> json) =>
      StoreOrderListData(
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
        items: List<OrderItems>.from(
            json["items"].map((x) => OrderItems.fromJson(x))),
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
      };
}

class OrderItems {
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
  dynamic imageUrl;
  int status;
  int createdBy;
  DateTime createdDate;
  dynamic updatedBy;
  dynamic updatedDate;

  OrderItems({
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

  factory OrderItems.fromJson(Map<String, dynamic> json) => OrderItems(
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
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}
