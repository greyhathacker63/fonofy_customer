// To parse this JSON data, do
//
//     final brandListModel = brandListModelFromJson(jsonString);

import 'dart:convert';

List<BrandListModel> brandListModelFromJson(String str) => List<BrandListModel>.from(json.decode(str).map((x) => BrandListModel.fromJson(x)));

String brandListModelToJson(List<BrandListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BrandListModel {
  dynamic id;
  String? brandImage;
  String? brandName;
  dynamic bToB;
  String? bToC;
  String? offerImage;

  BrandListModel({
    this.id,
    this.brandImage,
    this.brandName,
    this.bToB,
    this.bToC,
    this.offerImage,
  });

  factory BrandListModel.fromJson(Map<String, dynamic> json) => BrandListModel(
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
