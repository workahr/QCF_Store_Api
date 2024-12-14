// To parse this JSON data, do
//
//     final menuEditmodel = menuEditmodelFromJson(jsonString);

import 'dart:convert';

AdminMenuEditmodel adminmenuEditmodelFromJson(String str) =>
    AdminMenuEditmodel.fromJson(json.decode(str));

String adminmenuEditmodelToJson(AdminMenuEditmodel data) =>
    json.encode(data.toJson());

class AdminMenuEditmodel {
  String? status;
  AdminMenuEdit list;
  String? code;
  String? message;

  AdminMenuEditmodel({
    this.status,
    required this.list,
    this.code,
    this.message,
  });

  factory AdminMenuEditmodel.fromJson(Map<String, dynamic> json) =>
      AdminMenuEditmodel(
        status: json["status"],
        list: AdminMenuEdit.fromJson(json["list"]),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "list": list?.toJson(),
        "code": code,
        "message": message,
      };
}

class AdminMenuEdit {
  int itemId;
  int? storeId;
  String? itemName;
  int? itemType;
  String? itemDesc;
  String? itemPrice;
  String? storePrice;
  String? itemOfferPrice;
  int? itemPriceType;
  int? itemCategoryId;
  int? taxId;
  String? itemImageUrl;
  int? itemStock;
  String? itemTags;
  int? status;
  int? createdBy;
  DateTime? createdDate;
  int? updatedBy;
  DateTime? updatedDate;

  AdminMenuEdit({
    required this.itemId,
    this.storeId,
    this.itemName,
    this.itemType,
    this.itemDesc,
    this.itemPrice,
    this.storePrice,
    this.itemOfferPrice,
    this.itemPriceType,
    this.itemCategoryId,
    this.taxId,
    this.itemImageUrl,
    this.itemStock,
    this.itemTags,
    this.status,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
  });

  factory AdminMenuEdit.fromJson(Map<String, dynamic> json) => AdminMenuEdit(
        itemId: json["item_id"],
        storeId: json["store_id"],
        itemName: json["item_name"],
        itemType: json["item_type"],
        itemDesc: json["item_desc"],
        itemPrice: json["item_price"],
        storePrice: json["store_price"],
        itemOfferPrice: json["item_offer_price"],
        itemPriceType: json["item_price_type"],
        itemCategoryId: json["item_category_id"],
        taxId: json["tax_id"],
        itemImageUrl: json["item_image_url"],
        itemStock: json["item_stock"],
        itemTags: json["item_tags"],
        status: json["status"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"] == null
            ? null
            : DateTime.parse(json["updated_date"]),
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "store_id": storeId,
        "item_name": itemName,
        "item_type": itemType,
        "item_desc": itemDesc,
        "item_price": itemPrice,
        "store_price": storePrice,
        "item_offer_price": itemOfferPrice,
        "item_price_type": itemPriceType,
        "item_category_id": itemCategoryId,
        "tax_id": taxId,
        "item_image_url": itemImageUrl,
        "item_stock": itemStock,
        "item_tags": itemTags,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate?.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate!.toIso8601String(),
      };
}
