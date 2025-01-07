// To parse this JSON data, do
//
//     final adminDashboardrecordListmodel = adminDashboardrecordListmodelFromJson(jsonString);

import 'dart:convert';

AdminDashboardrecordListmodel adminDashboardrecordListmodelFromJson(
        String str) =>
    AdminDashboardrecordListmodel.fromJson(json.decode(str));

String adminDashboardrecordListmodelToJson(
        AdminDashboardrecordListmodel data) =>
    json.encode(data.toJson());

class AdminDashboardrecordListmodel {
  String status;
  DashboardRecord list;
  String code;
  String message;

  AdminDashboardrecordListmodel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory AdminDashboardrecordListmodel.fromJson(Map<String, dynamic> json) =>
      AdminDashboardrecordListmodel(
        status: json["status"],
        list: DashboardRecord.fromJson(json["list"]),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "list": list.toJson(),
        "code": code,
        "message": message,
      };
}

class DashboardRecord {
  String totalearn;
  int totalcount;
  int todaycount;
  int todayearn;
  int todaystoreearn;
  int todayadminearn;
  int storecount;
  int deliveryboycount;

  DashboardRecord({
    required this.totalearn,
    required this.totalcount,
    required this.todaycount,
    required this.todayearn,
    required this.todaystoreearn,
    required this.todayadminearn,
    required this.storecount,
    required this.deliveryboycount,
  });

  factory DashboardRecord.fromJson(Map<String, dynamic> json) =>
      DashboardRecord(
        totalearn: json["totalearn"],
        totalcount: json["totalcount"],
        todaycount: json["todaycount"],
        todayearn: json["todayearn"],
        todaystoreearn: json["todaystoreearn"],
        todayadminearn: json["todayadminearn"],
        storecount: json["storecount"],
        deliveryboycount: json["deliveryboycount"],
      );

  Map<String, dynamic> toJson() => {
        "totalearn": totalearn,
        "totalcount": totalcount,
        "todaycount": todaycount,
        "todayearn": todayearn,
        "todaystoreearn": todaystoreearn,
        "todayadminearn": todayadminearn,
        "storecount": storecount,
        "deliveryboycount": deliveryboycount,
      };
}
