// To parse this JSON data, do
//
//     final menuListmodel = menuListmodelFromJson(jsonString);

import 'dart:convert';

MenuListmodel menuListmodelFromJson(String str) =>
    MenuListmodel.fromJson(json.decode(str));

String menuListmodelToJson(MenuListmodel data) => json.encode(data.toJson());

class MenuListmodel {
  String status;
  List<MenuList> list;
  String code;
  String message;

  MenuListmodel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory MenuListmodel.fromJson(Map<String, dynamic> json) => MenuListmodel(
        status: json["status"],
        list:
            List<MenuList>.from(json["list"].map((x) => MenuList.fromJson(x))),
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

class MenuList {
  int itemId;
  int storeId;
  String itemName;
  int itemType;
  String? itemDesc;
  String itemPrice;
  String storePrice;
  String itemOfferPrice;
  int itemPriceType;
  int itemCategoryId;
  int taxId;
  String? itemImageUrl;
  int itemStock;
  String? itemTags;
  int status;
  int? createdBy;
  DateTime? createdDate;
  int? updatedBy;
  String? updatedDate;

  MenuList({
    required this.itemId,
    required this.storeId,
    required this.itemName,
    required this.itemType,
    this.itemDesc,
    required this.itemPrice,
    required this.storePrice,
    required this.itemOfferPrice,
    required this.itemPriceType,
    required this.itemCategoryId,
    required this.taxId,
    this.itemImageUrl,
    required this.itemStock,
    this.itemTags,
    required this.status,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
  });

  factory MenuList.fromJson(Map<String, dynamic> json) => MenuList(
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
        createdBy: json["created_by"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
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
        "updated_date": updatedDate,
      };
}
