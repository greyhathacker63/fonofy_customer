// To parse this JSON data, do
//
//     final brandListModel = brandListModelFromJson(jsonString);

import 'dart:convert';

List<RepairBrandListModel> brandListModelFromJson(String str) => List<RepairBrandListModel>.from(json.decode(str).map((x) => RepairBrandListModel.fromJson(x)));

String brandListModelToJson(List<RepairBrandListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RepairBrandListModel {
  dynamic id;
  String? brandImage;
  String? brandName;
  dynamic bToB;
  String? bToC;
  String? offerImage;

  RepairBrandListModel({
    this.id,
    this.brandImage,
    this.brandName,
    this.bToB,
    this.bToC,
    this.offerImage,
  });

  factory RepairBrandListModel.fromJson(Map<String, dynamic> json) => RepairBrandListModel(
    id: json["id"],
    brandImage: json["BrandImage"],
    brandName: json["BrandName"],
    bToB: json["BToB"],
    bToC: json["BToC"],
    offerImage: json["OfferImage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "BrandImage": brandImage,
    "BrandName": brandName,
    "BToB": bToB,
    "BToC": bToC,
    "OfferImage": offerImage,
  };
}
