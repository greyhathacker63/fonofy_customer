// To parse this JSON data, do
//
//     final productImageListModel = productImageListModelFromJson(jsonString);

import 'dart:convert';

List<ProductImageListModel> productImageListModelFromJson(String str) =>
    List<ProductImageListModel>.from(
        json.decode(str).map((x) => ProductImageListModel.fromJson(x)));

String productImageListModelToJson(List<ProductImageListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductImageListModel {
  dynamic? id;
  dynamic? modelId;
  String? image;
  bool? status;
  bool? isdelete;
  DateTime? createDate;
  dynamic? topImage;
  dynamic? ramId;
  dynamic? romId;
  dynamic? colorId;
  RowCode? rowCode;
  SpecificationsUcode? specificationsUcode;

  ProductImageListModel({
    this.id,
    this.modelId,
    this.image,
    this.status,
    this.isdelete,
    this.createDate,
    this.topImage,
    this.ramId,
    this.romId,
    this.colorId,
    this.rowCode,
    this.specificationsUcode,
  });

  factory ProductImageListModel.fromJson(Map<String, dynamic> json) =>
      ProductImageListModel(
        id: json["Id"],
        modelId: json["ModelId"],
        image: json["Image"],
        status: json["Status"],
        isdelete: json["Isdelete"],
        createDate: json["CreateDate"] == null
            ? null
            : DateTime.parse(json["CreateDate"]),
        topImage: json["TopImage"],
        ramId: json["RamId"],
        romId: json["RomId"],
        colorId: json["ColorId"],
        rowCode: rowCodeValues.map[json["RowCode"]]!,
        specificationsUcode:
            specificationsUcodeValues.map[json["specificationsUcode"]]!,
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ModelId": modelId,
        "Image": image,
        "Status": status,
        "Isdelete": isdelete,
        "CreateDate": createDate?.toIso8601String(),
        "TopImage": topImage,
        "RamId": ramId,
        "RomId": romId,
        "ColorId": colorId,
        "RowCode": rowCodeValues.reverse[rowCode],
        "specificationsUcode":
            specificationsUcodeValues.reverse[specificationsUcode],
      };
}

enum RowCode { ROW_161320251113270288125, ROW_1613202511132954611155 }

final rowCodeValues = EnumValues({
  "Row_161320251113270288125": RowCode.ROW_161320251113270288125,
  "Row_1613202511132954611155": RowCode.ROW_1613202511132954611155
});

enum SpecificationsUcode {
  THE_16132025111326964_A44_E0482_29_EE_4_B9_B_856_D_31515_D945_C83
}

final specificationsUcodeValues = EnumValues({
  "16132025111326964a44e0482-29ee-4b9b-856d-31515d945c83": SpecificationsUcode
      .THE_16132025111326964_A44_E0482_29_EE_4_B9_B_856_D_31515_D945_C83
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
