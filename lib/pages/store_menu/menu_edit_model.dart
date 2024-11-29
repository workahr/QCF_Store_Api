// To parse this JSON data, do
//
//     final menuEditmodel = menuEditmodelFromJson(jsonString);

import 'dart:convert';

MenuEditmodel menuEditmodelFromJson(String str) =>
    MenuEditmodel.fromJson(json.decode(str));

String menuEditmodelToJson(MenuEditmodel data) => json.encode(data.toJson());

class MenuEditmodel {
  String? status;
  MenuEdit list;
  String? code;
  String? message;

  MenuEditmodel({
    this.status,
    required this.list,
    this.code,
    this.message,
  });

  factory MenuEditmodel.fromJson(Map<String, dynamic> json) => MenuEditmodel(
        status: json["status"],
        list: MenuEdit.fromJson(json["list"]),
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

class MenuEdit {
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

  MenuEdit({
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

  factory MenuEdit.fromJson(Map<String, dynamic> json) => MenuEdit(
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
