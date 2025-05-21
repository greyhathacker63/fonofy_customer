// To parse this JSON data, do
//
//     final brandBasedModel = brandBasedModelFromJson(jsonString);

import 'dart:convert';

List<BrandBasedModel> brandBasedModelFromJson(String str) => List<BrandBasedModel>.from(json.decode(str).map((x) => BrandBasedModel.fromJson(x)));

String brandBasedModelToJson(List<BrandBasedModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BrandBasedModel {
  int brandId;
  int productId;
  String? productAndModelName;
  String? image;

  BrandBasedModel({
    required this.brandId,
    required this.productId,
    this.productAndModelName,
    this.image,
  });

  factory BrandBasedModel.fromJson(Map<String, dynamic> json) => BrandBasedModel(
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
