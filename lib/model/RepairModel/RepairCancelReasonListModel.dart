// To parse this JSON data, do
//
//     final repairCancelReasonListModel = repairCancelReasonListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RepairCancelReasonListModel repairCancelReasonListModelFromJson(String str) => RepairCancelReasonListModel.fromJson(json.decode(str));

String repairCancelReasonListModelToJson(RepairCancelReasonListModel data) => json.encode(data.toJson());

class RepairCancelReasonListModel {
  List<Table> table;
  List<Table> table1;

  RepairCancelReasonListModel({
    required this.table,
    required this.table1,
  });

  RepairCancelReasonListModel copyWith({
    List<Table>? table,
    List<Table>? table1,
  }) =>
      RepairCancelReasonListModel(
        table: table ?? this.table,
        table1: table1 ?? this.table1,
      );

  factory RepairCancelReasonListModel.fromJson(Map<String, dynamic> json) => RepairCancelReasonListModel(
    table: List<Table>.from(json["Table"].map((x) => Table.fromJson(x))),
    table1: List<Table>.from(json["Table1"].map((x) => Table.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Table": List<dynamic>.from(table.map((x) => x.toJson())),
    "Table1": List<dynamic>.from(table1.map((x) => x.toJson())),
  };
}

class Table {
  int id;
  String actionType;
  String reason;
  String serviceType;
  int cmpCode;
  String userId;
  int gowdownId;
  DateTime createdDate;
  bool isdelete;
  bool status;

  Table({
    required this.id,
    required this.actionType,
    required this.reason,
    required this.serviceType,
    required this.cmpCode,
    required this.userId,
    required this.gowdownId,
    required this.createdDate,
    required this.isdelete,
    required this.status,
  });

  Table copyWith({
    int? id,
    String? actionType,
    String? reason,
    String? serviceType,
    int? cmpCode,
    String? userId,
    int? gowdownId,
    DateTime? createdDate,
    bool? isdelete,
    bool? status,
  }) =>
      Table(
        id: id ?? this.id,
        actionType: actionType ?? this.actionType,
        reason: reason ?? this.reason,
        serviceType: serviceType ?? this.serviceType,
        cmpCode: cmpCode ?? this.cmpCode,
        userId: userId ?? this.userId,
        gowdownId: gowdownId ?? this.gowdownId,
        createdDate: createdDate ?? this.createdDate,
        isdelete: isdelete ?? this.isdelete,
        status: status ?? this.status,
      );

  factory Table.fromJson(Map<String, dynamic> json) => Table(
    id: json["Id"],
    actionType: json["ActionType"],
    reason: json["Reason"],
    serviceType: json["ServiceType"],
    cmpCode: json["CmpCode"],
    userId: json["UserId"],
    gowdownId: json["GowdownId"],
    createdDate: DateTime.parse(json["CreatedDate"]),
    isdelete: json["Isdelete"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "ActionType": actionType,
    "Reason": reason,
    "ServiceType": serviceType,
    "CmpCode": cmpCode,
    "UserId": userId,
    "GowdownId": gowdownId,
    "CreatedDate": createdDate.toIso8601String(),
    "Isdelete": isdelete,
    "Status": status,
  };
}
