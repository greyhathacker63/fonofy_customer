// To parse this JSON data, do
//
//     final brandBasedModel = brandBasedModelFromJson(jsonString);

import 'dart:convert';

List<SellBrandBasedModel> brandBasedModelFromJson(String str) => List<SellBrandBasedModel>.from(json.decode(str).map((x) => SellBrandBasedModel.fromJson(x)));

String brandBasedModelToJson(List<SellBrandBasedModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SellBrandBasedModel {
  int brandId;
  int productId;
  String? productAndModelName;
  String? image;

  SellBrandBasedModel({
    required this.brandId,
    required this.productId,
    this.productAndModelName,
    this.image,
  });

  factory SellBrandBasedModel.fromJson(Map<String, dynamic> json) => SellBrandBasedModel(
    brandId: json["BrandId"],
    productId: json["ProductId"],
    productAndModelName: json["ProductAndModelName"],
    image: json["Image"],
  );

  Map<String, dynamic> toJson() => {
    "BrandId": brandId,
    "ProductId": productId,
    "ProductAndModelName": productAndModelName,
    "Image": image,
  };
}
