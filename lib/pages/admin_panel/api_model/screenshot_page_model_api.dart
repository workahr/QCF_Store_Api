// // To parse this JSON data, do
// //
// //     final screenshotPageModel = screenshotPageModelFromJson(jsonString);

// import 'dart:convert';

// ScreenshotPageModel screenshotPageModelFromJson(String str) =>
//     ScreenshotPageModel.fromJson(json.decode(str));

// String screenshotPageModelToJson(ScreenshotPageModel data) =>
//     json.encode(data.toJson());

// class ScreenshotPageModel {
//   String status;
//   List<ScreeenShots> list;
//   String code;
//   String message;

//   ScreenshotPageModel({
//     required this.status,
//     required this.list,
//     required this.code,
//     required this.message,
//   });

//   factory ScreenshotPageModel.fromJson(Map<String, dynamic> json) =>
//       ScreenshotPageModel(
//         status: json["status"],
//         list: List<ScreeenShots>.from(
//             json["list"].map((x) => ScreeenShots.fromJson(x))),
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

// class ScreeenShots {
//   int? id;
//   DateTime date;
//   int? storeId;
//   int? orderIds;
//   String? amount;
//   String? paymentMethod;
//   String? imageUrl;
//   int? status;
//   int? createdBy;
//   DateTime createdDate;
//   String? storeName;
//   String? storeMobile;

//   ScreeenShots({
//     this.id,
//     required this.date,
//     this.storeId,
//     this.orderIds,
//     this.amount,
//     this.paymentMethod,
//     this.imageUrl,
//     this.status,
//     this.createdBy,
//     required this.createdDate,
//     this.storeName,
//     this.storeMobile,
//   });

//   factory ScreeenShots.fromJson(Map<String, dynamic> json) => ScreeenShots(
//         id: json["id"],
//         date: DateTime.parse(json["date"]),
//         storeId: json["store_id"],
//         orderIds: json["order_ids"],
//         amount: json["amount"],
//         paymentMethod: json["payment_method"],
//         imageUrl: json["image_url"],
//         status: json["status"],
//         createdBy: json["created_by"],
//         createdDate: DateTime.parse(json["created_date"]),
//         storeName: json["store_name"],
//         storeMobile: json["store_mobile"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "date":
//             "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
//         "store_id": storeId,
//         "order_ids": orderIds,
//         "amount": amount,
//         "payment_method": paymentMethod,
//         "image_url": imageUrl,
//         "status": status,
//         "created_by": createdBy,
//         "created_date": createdDate.toIso8601String(),
//         "store_name": storeName,
//         "store_mobile": storeMobile,
//       };
// }

import 'dart:convert';

import 'package:intl/intl.dart';

// Function to parse JSON data into ScreenshotPageModel
ScreenshotPageModel screenshotPageModelFromJson(String str) =>
    ScreenshotPageModel.fromJson(json.decode(str));

// Function to convert ScreenshotPageModel back to JSON
String screenshotPageModelToJson(ScreenshotPageModel data) =>
    json.encode(data.toJson());

class ScreenshotPageModel {
  String status;
  List<ScreeenShots> list;
  String code;
  String message;

  ScreenshotPageModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  // Factory constructor to create a ScreenshotPageModel instance from JSON
  factory ScreenshotPageModel.fromJson(Map<String, dynamic> json) =>
      ScreenshotPageModel(
        status: json["status"] ?? "",
        list: json["list"] != null
            ? List<ScreeenShots>.from(
                json["list"].map((x) => ScreeenShots.fromJson(x)))
            : [], // Provide an empty list if null
        code: json["code"] ?? "",
        message: json["message"] ?? "",
      );

  // Method to convert ScreenshotPageModel instance to JSON
  Map<String, dynamic> toJson() => {
        "status": status,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "code": code,
        "message": message,
      };
}

class ScreeenShots {
  int? id;
  DateTime? date;
  int? storeId;
  int? orderIds;
  String? amount;
  String? paymentMethod;
  String? imageUrl;
  int? status;
  int? createdBy;
  String? createdDate;
  String? storeName;
  String? storeMobile;
  String? ownerName;
  String? address;
  String? state;
  String? city;
  String? zipcode;

  ScreeenShots({
    this.id,
    this.date,
    this.storeId,
    this.orderIds,
    this.amount,
    this.paymentMethod,
    this.imageUrl,
    this.status,
    this.createdBy,
    this.createdDate,
    this.storeName,
    this.storeMobile,
    this.ownerName,
    this.address,
    this.state,
    this.city,
    this.zipcode,
  });

  // Factory constructor to create a ScreeenShots instance from JSON
  factory ScreeenShots.fromJson(Map<String, dynamic> json) => ScreeenShots(
        id: json["id"],
        date: json["date"] != null ? DateTime.parse(json["date"]) : null,
        storeId: json["store_id"],
        orderIds: json["order_ids"],
        amount: json["amount"],
        paymentMethod: json["payment_method"],
        imageUrl: json["image_url"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: json["created_date"],
        storeName: json["store_name"],
        storeMobile: json["store_mobile"],
        ownerName: json["owner_name"],
        address: json["address"],
        state: json["state"],
        city: json["city"],
        zipcode: json["zipcode"],
      );

  // Method to convert ScreeenShots instance to JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date?.toIso8601String(),
        "store_id": storeId,
        "order_ids": orderIds,
        "amount": amount,
        "payment_method": paymentMethod,
        "image_url": imageUrl,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate,
        "store_name": storeName,
        "store_mobile": storeMobile,
        "owner_name": ownerName,
        "address": address,
        "state": state,
        "city": city,
        "zipcode": zipcode,
      };

  // Get formatted date
  String get formattedDate {
    if (date == null) return "N/A";
    return DateFormat("yyyy-MM-dd").format(date!); // Formats as YYYY-MM-DD
  }

  // Get formatted time
  String get formattedTime {
    if (date == null) return "N/A";
    return DateFormat("hh:mm a").format(date!); // Formats as HH:MM AM/PM
  }

  // Helper function for parsing date
  static DateTime? _parseDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;
    try {
      return DateTime.parse(dateStr);
    } catch (e) {
      return null; // Handle invalid date format
    }
  }
}
