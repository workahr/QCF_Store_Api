import 'dart:convert';

// To parse this JSON data, do:
// final paymentsPageModel = paymentsPageModelFromJson(jsonString);

PaymentsPageModel paymentsPageModelFromJson(String str) =>
    PaymentsPageModel.fromJson(json.decode(str));

String paymentsPageModelToJson(PaymentsPageModel data) =>
    json.encode(data.toJson());

class PaymentsPageModel {
  String status;
  List<Payments> list;
  String code;
  String message;

  PaymentsPageModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory PaymentsPageModel.fromJson(Map<String, dynamic> json) =>
      PaymentsPageModel(
        status: json["status"],
        list:
            List<Payments>.from(json["list"].map((x) => Payments.fromJson(x))),
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

class Payments {
  int? storeId;
  String? name;
  String? mobile;
  String? email;
  DateTime? date;
  int? totalOrderCount;
  int? totalOrderAmount;
  int? totalStoreAmount;
  int? totalAggregator;
  int? givenToStore;
  int? pendingAmount;

  Payments({
    this.storeId,
    this.name,
    this.mobile,
    this.email,
    this.date,
    this.totalOrderCount,
    this.totalOrderAmount,
    this.totalStoreAmount,
    this.totalAggregator,
    this.givenToStore,
    this.pendingAmount,
  });

  factory Payments.fromJson(Map<String, dynamic> json) => Payments(
        storeId: json["store_id"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        date: _parseDate(json["date"]),
        totalOrderCount: json["total_order_count"],
        totalOrderAmount: json["total_order_amount"],
        totalStoreAmount: json["total_store_amount"],
        totalAggregator: json["total_aggregator"],
        givenToStore: json["given_to_store"],
        pendingAmount: json["pending_amount"],
      );

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "name": name,
        "mobile": mobile,
        "email": email,
        "date": date?.toIso8601String(),
        "total_order_count": totalOrderCount,
        "total_order_amount": totalOrderAmount,
        "total_store_amount": totalStoreAmount,
        "total_aggregator": totalAggregator,
        "given_to_store": givenToStore,
        "pending_amount": pendingAmount,
      };

  // Custom date parsing function
  static DateTime? _parseDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;
    try {
      return DateTime.parse(dateStr);
    } catch (e) {
      // Handle invalid date format here (e.g., log the error or return null)
      return null;
    }
  }
}
