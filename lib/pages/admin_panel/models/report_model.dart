// To parse this JSON data, do
//
//     final dashboardlistmodel = dashboardlistmodelFromJson(jsonString);

import 'dart:convert';

ReportModel reportmodelFromJson(String str) =>
    ReportModel.fromJson(json.decode(str));

String reportmodelToJson(ReportModel data) => json.encode(data.toJson());

class ReportModel {
  String status;
  List<ReportList> list;
  String code;
  String message;

  ReportModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        status: json["status"],
        list: List<ReportList>.from(
            json["list"].map((x) => ReportList.fromJson(x))),
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

class ReportList {
  int id;
  String snumber;
  String storename;

  String date;

  int status;
  int active;
  int createdBy;
  dynamic createdDate;
  int updatedBy;
  dynamic updatedDate;

  ReportList({
    required this.id,
    required this.snumber,
    required this.storename,
    required this.date,
    required this.status,
    required this.active,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory ReportList.fromJson(Map<String, dynamic> json) => ReportList(
        id: json["id"],
        snumber: json["snumber"],
        storename: json["storename"],
        date: json["date"],
        status: json["status"],
        active: json["active"],
        createdBy: json["created_by"],
        createdDate: json["created_date"],
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "snumber": snumber,
        "storename": storename,
        "date": date,
        "status": status,
        "active": active,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}
