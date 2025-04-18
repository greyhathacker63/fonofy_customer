// To parse this JSON data, do
//
//     final productDetailsListModel = productDetailsListModelFromJson(jsonString);

import 'dart:convert';

List<ProductDetailsListModel> productDetailsListModelFromJson(String str) => List<ProductDetailsListModel>.from(json.decode(str).map((x) => ProductDetailsListModel.fromJson(x)));

String productDetailsListModelToJson(List<ProductDetailsListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductDetailsListModel {
  String? modelNo;
  String? productAndModelName;
  String? ramName;
  String? romName;
  String? colorName;
  dynamic? ramId;
  dynamic? romId;
  dynamic? colorId;
  String? modelType;
  dynamic? newModelAmt;
  String? modelUrl;
  String? ucode;
  dynamic? amount;
  dynamic? discountPercentage;
  dynamic? wishlistCount;
  String? image;

  ProductDetailsListModel({
    this.modelNo,
    this.productAndModelName,
    this.ramName,
    this.romName,
    this.colorName,
    this.ramId,
    this.romId,
    this.colorId,
    this.modelType,
    this.newModelAmt,
    this.modelUrl,
    this.ucode,
    this.amount,
    this.discountPercentage,
    this.wishlistCount,
    this.image,
  });

  factory ProductDetailsListModel.fromJson(Map<String, dynamic> json) => ProductDetailsListModel(
    modelNo: json["ModelNo"],
    productAndModelName: json["ProductAndModelName"],
    ramName: json["RamName"],
    romName: json["RomName"],
    colorName: json["ColorName"],
    ramId: json["RamId"],
    romId: json["RomId"],
    colorId: json["ColorId"],
    modelType: json["ModelType"],
    newModelAmt: json["NewModelAmt"],
    modelUrl: json["ModelUrl"],
    ucode: json["Ucode"],
    amount: json["Amount"],
    discountPercentage: json["DiscountPercentage"],
    wishlistCount: json["WishlistCount"],
    image: json["Image"],
  );


  Map<String, dynamic> toJson() => {
    "ModelNo": modelNo,
    "ProductAndModelName": productAndModelName,
    "RamName": ramName,
    "RomName": romName,
    "ColorName": colorName,
    "RamId": ramId,
    "RomId": romId,
    "ColorId": colorId,
    "ModelType": modelType,
    "NewModelAmt": newModelAmt,
    "ModelUrl": modelUrl,
    "Ucode": ucode,
    "Amount": amount,
    "DiscountPercentage": discountPercentage,
    "WishlistCount": wishlistCount,
    "Image": image,
  };
}
