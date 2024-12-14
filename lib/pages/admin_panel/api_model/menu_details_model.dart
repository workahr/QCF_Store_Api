// // To parse this JSON data, do
// //
// //     final storemenulistmodel = storemenulistmodelFromJson(jsonString);

// import 'dart:convert';

// Storemenulistadminmodel storemenulistmodelFromJson(String str) =>
//     Storemenulistadminmodel.fromJson(json.decode(str));

// String storemenulistmodelToJson(Storemenulistadminmodel data) =>
//     json.encode(data.toJson());

// class Storemenulistadminmodel {
//   String status;
//   List<MenuDetailList> list;
//   String code;
//   String message;

//   Storemenulistadminmodel({
//     required this.status,
//     required this.list,
//     required this.code,
//     required this.message,
//   });

//   factory Storemenulistadminmodel.fromJson(Map<String, dynamic> json) =>
//       Storemenulistadminmodel(
//         status: json["status"],
//         list: List<MenuDetailList>.from(
//             json["list"].map((x) => MenuDetailList.fromJson(x))),
//         code: json["code"],
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "list": List<dynamic>.from(list.map((x) => x.toJson())),
//         "code": code,
//         "message": message,
//       };
// }

// class MenuDetailList {
//   int id;
//   String dishtype;
//   String dishname;
//   String image;
//   String amount;
//   bool stock;
//   int status;
//   int active;
//   int createdBy;
//   dynamic createdDate;
//   int updatedBy;
//   dynamic updatedDate;

//   MenuDetailList({
//     required this.id,
//     required this.dishtype,
//     required this.dishname,
//     required this.image,
//     required this.amount,
//     required this.stock,
//     required this.status,
//     required this.active,
//     required this.createdBy,
//     required this.createdDate,
//     required this.updatedBy,
//     required this.updatedDate,
//   });

//   factory MenuDetailList.fromJson(Map<String, dynamic> json) => MenuDetailList(
//         id: json["id"],
//         dishtype: json["dishtype"],
//         dishname: json["dishname"],
//         image: json["image"],
//         amount: json["amount"],
//         stock: json["stock"],
//         status: json["status"],
//         active: json["active"],
//         createdBy: json["created_by"],
//         createdDate: json["created_date"],
//         updatedBy: json["updated_by"],
//         updatedDate: json["updated_date"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "dishtype": dishtype,
//         "dishname": dishname,
//         "image": image,
//         "amount": amount,
//         "stock": stock,
//         "status": status,
//         "active": active,
//         "created_by": createdBy,
//         "created_date": createdDate,
//         "updated_by": updatedBy,
//         "updated_date": updatedDate,
//       };
// }

// To parse this JSON data, do
//
//     final menuDetailsAdminmodel = menuDetailsAdminmodelFromJson(jsonString);

import 'dart:convert';

MenuDetailsAdminmodel menuDetailsAdminmodelFromJson(String str) =>
    MenuDetailsAdminmodel.fromJson(json.decode(str));

String menuDetailsAdminmodelToJson(MenuDetailsAdminmodel data) =>
    json.encode(data.toJson());

class MenuDetailsAdminmodel {
  String status;
  List<MenuDetails> list;
  String code;
  String message;

  MenuDetailsAdminmodel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory MenuDetailsAdminmodel.fromJson(Map<String, dynamic> json) =>
      MenuDetailsAdminmodel(
        status: json["status"],
        list: List<MenuDetails>.from(
            json["list"].map((x) => MenuDetails.fromJson(x))),
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

class MenuDetails {
  int itemId;
  int storeId;
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
  int status;
  int? createdBy;
  DateTime? createdDate;
  int? updatedBy;
  DateTime? updatedDate;

  MenuDetails({
    required this.itemId,
    required this.storeId,
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
    required this.status,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
  });

  factory MenuDetails.fromJson(Map<String, dynamic> json) => MenuDetails(
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
        "updated_date": updatedDate?.toIso8601String(),
      };
}







// import 'dart:convert';

// // Convert JSON string to MenuDetailsAdminmodel object
// MenuDetailsAdminmodel menuDetailsAdminmodelFromJson(String str) =>
//     MenuDetailsAdminmodel.fromJson(json.decode(str));

// // Convert MenuDetailsAdminmodel object to JSON string
// String menuDetailsAdminmodelToJson(MenuDetailsAdminmodel data) =>
//     json.encode(data.toJson());

// // Main model for the API response
// class MenuDetailsAdminmodel {
//   String status;
//   List<MenuDetails> list;
//   String code;
//   String message;

//   MenuDetailsAdminmodel({
//     required this.status,
//     required this.list,
//     required this.code,
//     required this.message,
//   });

//   // Factory constructor to parse JSON data
//   factory MenuDetailsAdminmodel.fromJson(Map<String, dynamic> json) {
//     return MenuDetailsAdminmodel(
//       status: json["status"] ?? "UNKNOWN", // Handle null status
//       list: json["list"] != null
//           ? List<MenuDetails>.from(
//               (json["list"] as List).map((x) => MenuDetails.fromJson(x)))
//           : [], // Empty list if null
//       code: json["code"] ?? "UNKNOWN", // Handle null code
//       message: json["message"] ?? "No message", // Handle null message
//     );
//   }

//   // Convert object back to JSON
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "list": List<dynamic>.from(list.map((x) => x.toJson())),
//         "code": code,
//         "message": message,
//       };
// }

// // Model for individual menu details
// class MenuDetails {
//   int? itemId;
//   int? storeId;
//   String? itemName;
//   int? itemType;
//   String? itemDesc;
//   String? itemPrice;
//   String? storePrice;
//   String? itemOfferPrice;
//   int? itemPriceType;
//   int? itemCategoryId;
//   int? taxId;
//   String? itemImageUrl;
//   int? itemStock;
//   String? itemTags;
//   int? status;
//   int? createdBy;
//   DateTime? createdDate;
//   int? updatedBy;
//   DateTime? updatedDate;

//   MenuDetails({
//     this.itemId,
//     this.storeId,
//     this.itemName,
//     this.itemType,
//     this.itemDesc,
//     this.itemPrice,
//     this.storePrice,
//     this.itemOfferPrice,
//     this.itemPriceType,
//     this.itemCategoryId,
//     this.taxId,
//     this.itemImageUrl,
//     this.itemStock,
//     this.itemTags,
//     this.status,
//     this.createdBy,
//     this.createdDate,
//     this.updatedBy,
//     this.updatedDate,
//   });

//   // Factory constructor to parse JSON
//   factory MenuDetails.fromJson(Map<String, dynamic> json) {
//     return MenuDetails(
//       itemId: json["item_id"] ?? 0,
//       storeId: json["store_id"] ?? 0,
//       itemName: json["item_name"] ?? "Unknown Item",
//       itemType: json["item_type"] ?? 0,
//       itemDesc: json["item_desc"] ?? "",
//       itemPrice: json["item_price"] ?? "0.0",
//       storePrice: json["store_price"] ?? "0.0",
//       itemOfferPrice: json["item_offer_price"] ?? "0.0",
//       itemPriceType: json["item_price_type"] ?? 0,
//       itemCategoryId: json["item_category_id"] ?? 0,
//       taxId: json["tax_id"] ?? 0,
//       itemImageUrl: json["item_image_url"] ?? "",
//       itemStock: json["item_stock"] ?? 0,
//       itemTags: json["item_tags"] ?? "",
//       status: json["status"] ?? 0,
//       createdBy: json["created_by"] ?? 0,
//       createdDate: json["created_date"] != null
//           ? DateTime.tryParse(json["created_date"]) ?? null
//           : null,
//       updatedBy: json["updated_by"] ?? 0,
//       updatedDate: json["updated_date"] != null
//           ? DateTime.tryParse(json["updated_date"]) ?? null
//           : null,
//     );
//   }

//   // Convert object back to JSON
//   Map<String, dynamic> toJson() => {
//         "item_id": itemId,
//         "store_id": storeId,
//         "item_name": itemName,
//         "item_type": itemType,
//         "item_desc": itemDesc,
//         "item_price": itemPrice,
//         "store_price": storePrice,
//         "item_offer_price": itemOfferPrice,
//         "item_price_type": itemPriceType,
//         "item_category_id": itemCategoryId,
//         "tax_id": taxId,
//         "item_image_url": itemImageUrl,
//         "item_stock": itemStock,
//         "item_tags": itemTags,
//         "status": status,
//         "created_by": createdBy,
//         "created_date": createdDate?.toIso8601String(),
//         "updated_by": updatedBy,
//         "updated_date": updatedDate?.toIso8601String(),
//       };
// }

// // Validate the parsed data
// void validateMenuDetails(MenuDetailsAdminmodel model) {
//   assert(model.status.isNotEmpty, "Status is empty!");
//   assert(model.list.isNotEmpty, "Menu details list is empty!");
//   for (var menu in model.list) {
//     assert(menu.itemId != null, "Menu item ID is null!");
//     assert(menu.itemName != null && menu.itemName!.isNotEmpty,
//         "Menu item name is null or empty!");
//   }
// }

// // Example usage
// void main() {
//   String jsonResponse = '''
//   {
//     "status": "success",
//     "list": [
//       {
//         "item_id": 1,
//         "store_id": 2,
//         "item_name": "Burger",
//         "item_type": 1,
//         "item_desc": "Delicious burger",
//         "item_price": "5.99",
//         "store_price": "4.99",
//         "item_offer_price": "4.49",
//         "item_price_type": 0,
//         "item_category_id": 10,
//         "tax_id": 5,
//         "item_image_url": "https://example.com/burger.png",
//         "item_stock": 20,
//         "item_tags": "fast food,burger",
//         "status": 1,
//         "created_by": 101,
//         "created_date": "2024-12-01T12:00:00Z",
//         "updated_by": 102,
//         "updated_date": "2024-12-02T12:00:00Z"
//       }
//     ],
//     "code": "200",
//     "message": "Fetched successfully"
//   }
//   ''';

//   try {
//     // Parse the JSON
//     var menuModel = menuDetailsAdminmodelFromJson(jsonResponse);

//     // Validate the parsed data
//     validateMenuDetails(menuModel);

//     // Print parsed data
//     print("Status: ${menuModel.status}");
//     print("Code: ${menuModel.code}");
//     print("Message: ${menuModel.message}");
//     print("First item name: ${menuModel.list[0].itemName}");
//   } catch (e) {
//     print("Error: $e");
//   }
// }
