// To parse this JSON data, do
//
//     final productRamRomColorListModel = productRamRomColorListModelFromJson(jsonString);

import 'dart:convert';

List<ProductRamRomColorListModel> productRamRomColorListModelFromJson(
        String str) =>
    List<ProductRamRomColorListModel>.from(
        json.decode(str).map((x) => ProductRamRomColorListModel.fromJson(x)));

String productRamRomColorListModelToJson(
        List<ProductRamRomColorListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductRamRomColorListModel {
  dynamic id;
  dynamic specificationsid;
  String? specificationsUcode;
  dynamic modelNo;
  String? ramName;
  String? romName;
  String? colorName;
  dynamic ramId;
  dynamic romId;
  dynamic colorId;
  dynamic f1Plus;
  dynamic f1;
  dynamic f2;
  dynamic plusDisAmt;
  dynamic f1DisAmt;
  dynamic f2DisAmt;
  dynamic plusDis;
  dynamic f1Dis;
  dynamic f2Dis;
  String? type;
  bool? ideleted;
  bool? status;
  DateTime? createdDate;
  dynamic updateDate;
  String? rowCode;
  dynamic newAmount;

  ProductRamRomColorListModel({
    this.id,
    this.specificationsid,
    this.specificationsUcode,
    this.modelNo,
    this.ramName,
    this.romName,
    this.colorName,
    this.ramId,
    this.romId,
    this.colorId,
    this.f1Plus,
    this.f1,
    this.f2,
    this.plusDisAmt,
    this.f1DisAmt,
    this.f2DisAmt,
    this.plusDis,
    this.f1Dis,
    this.f2Dis,
    this.type,
    this.ideleted,
    this.status,
    this.createdDate,
    this.updateDate,
    this.rowCode,
    this.newAmount,
  });

  factory ProductRamRomColorListModel.fromJson(Map<String, dynamic> json) =>
      ProductRamRomColorListModel(
        id: json["Id"],
        specificationsid: json["specificationsid"],
        specificationsUcode: json["specificationsUcode"],
        modelNo: json["ModelNo"],
        ramName: json["RamName"],
        romName: json["RomName"],
        colorName: json["ColorName"],
        ramId: json["RamId"],
        romId: json["RomId"],
        colorId: json["ColorId"],
        f1Plus: json["F1_Plus"],
        f1: json["F1"],
        f2: json["F2"],
        plusDisAmt: json["PlusDisAmt"],
        f1DisAmt: json["F1DisAmt"],
        f2DisAmt: json["F2DisAmt"],
        plusDis: json["PlusDis"],
        f1Dis: json["F1Dis"],
        f2Dis: json["F2Dis"],
        type: json["Type"],
        ideleted: json["Ideleted"],
        status: json["Status"],
        createdDate: json["CreatedDate"] == null
            ? null
            : DateTime.parse(json["CreatedDate"]),
        updateDate: json["UpdateDate"],
        rowCode: json["RowCode"],
        newAmount: json["NewAmount"],
      );




  Map<String, dynamic> toJson() => {
        "Id": id,
        "specificationsid": specificationsid,
        "specificationsUcode": specificationsUcode,
        "ModelNo": modelNo,
        "RamName": ramName,
        "RomName": romName,
        "ColorName": colorName,
        "RamId": ramId,
        "RomId": romId,
        "ColorId": colorId,
        "F1_Plus": f1Plus,
        "F1": f1,
        "F2": f2,
        "PlusDisAmt": plusDisAmt,
        "F1DisAmt": f1DisAmt,
        "F2DisAmt": f2DisAmt,
        "PlusDis": plusDis,
        "F1Dis": f1Dis,
        "F2Dis": f2Dis,
        "Type": type,
        "Ideleted": ideleted,
        "Status": status,
        "CreatedDate": createdDate?.toIso8601String(),
        "UpdateDate": updateDate,
        "RowCode": rowCode,
        "NewAmount": newAmount,
      };
}
