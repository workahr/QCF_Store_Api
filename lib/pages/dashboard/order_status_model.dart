// To parse this JSON data, do
//
//     final orderStatusModel = orderStatusModelFromJson(jsonString);

import 'dart:convert';

OrderStatusModel orderStatusModelFromJson(String str) => OrderStatusModel.fromJson(json.decode(str));

String orderStatusModelToJson(OrderStatusModel data) => json.encode(data.toJson());

class OrderStatusModel {
    String status;
    String code;
    String message;

    OrderStatusModel({
        required this.status,
        required this.code,
        required this.message,
    });

    factory OrderStatusModel.fromJson(Map<String, dynamic> json) => OrderStatusModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
    };
}
