// To parse this JSON data, do
//
//     final repairServicesTableModel = repairServicesTableModelFromJson(jsonString);

import 'dart:convert';

RepairServicesTableModel repairServicesTableModelFromJson(String str) => RepairServicesTableModel.fromJson(json.decode(str));

String repairServicesTableModelToJson(RepairServicesTableModel data) => json.encode(data.toJson());

class RepairServicesTableModel {
  List<RepairDeviceTable>? table;
  List<Table1>? table1;

  RepairServicesTableModel({
    this.table,
    this.table1,
  });

  factory RepairServicesTableModel.fromJson(Map<String, dynamic> json) => RepairServicesTableModel(
    table: json["Table"] == null ? [] : List<RepairDeviceTable>.from(json["Table"]!.map((x) => RepairDeviceTable.fromJson(x))),
    table1: json["Table1"] == null ? [] : List<Table1>.from(json["Table1"]!.map((x) => Table1.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Table": table == null ? [] : List<dynamic>.from(table!.map((x) => x.toJson())),
    "Table1": table1 == null ? [] : List<dynamic>.from(table1!.map((x) => x.toJson())),
  };
}


class RepairDeviceTable {
  String? brand;
  String? modelNo;
  int? colorId;
  String? colorName;
  String? productAndModelName;

  RepairDeviceTable({
    this.brand,
    this.modelNo,
    this.colorId,
    this.colorName,
    this.productAndModelName,
  });

  factory RepairDeviceTable.fromJson(Map<String, dynamic> json) => RepairDeviceTable(
    brand: json["Brand"],
    modelNo: json["ModelNo"],
    colorId: json["ColorId"],
    colorName: json["ColorName"],
    productAndModelName: json["ProductAndModelName"],
  );

  Map<String, dynamic> toJson() => {
    "Brand": brand,
    "ModelNo": modelNo,
    "ColorId": colorId,
    "ColorName": colorName,
    "ProductAndModelName": productAndModelName,
  };
}

class Table1 {
  int? id;
  String? serviceName;
  String? serviceImage;
  dynamic mrp;
  dynamic discountAmount;
  dynamic disPercentage;
  double price;

  Table1({
    this.id,
    this.serviceName,
    this.serviceImage,
    this.mrp,
    this.discountAmount,
    this.disPercentage,
    required this.price,
  });

  factory Table1.fromJson(Map<String, dynamic> json) => Table1(
    id: json["Id"],
    serviceName: json["ServiceName"],
    serviceImage: json["ServiceImage"],
    mrp: json["MRP"],
    discountAmount: json["DiscountAmount"],
    disPercentage: json["DisPercentage"],
    price: json["Price"],
  );
  Map<String, dynamic> toJson() => {
    "Id": id,
    "ServiceName": serviceName,
    "ServiceImage": serviceImage,
    "MRP": mrp,
    "DiscountAmount": discountAmount,
    "DisPercentage": disPercentage,
    "Price": price,
  };
}
