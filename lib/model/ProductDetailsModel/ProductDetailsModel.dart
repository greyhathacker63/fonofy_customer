// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

List<ProductDetailsModel> productDetailsModelFromJson(String str) => List<ProductDetailsModel>.from(json.decode(str).map((x) => ProductDetailsModel.fromJson(x)));

String productDetailsModelToJson(List<ProductDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductDetailsModel {
  String? description;
  dynamic? modelNo;
  String? productAndModelName;
  String? modelType;
  dynamic? newModelAmt;
  dynamic? sellingPricePlus;
  dynamic? sellingPriceF1;
  dynamic? sellingPriceF2;
  dynamic? discountPercentage;
  String? modelUrl;
  String? ramName;
  String? romName;
  String? colorName;
  dynamic? ramId;
  dynamic? romId;
  dynamic? colorId;
  dynamic? f1Plus;
  dynamic? f1;
  dynamic? id;
  String? ucode;
  dynamic? sellingPrice;
  String? processor;
  String? display;
  String? rearCamera;
  String? frontCamera;
  String? battery;
  dynamic? wishlistCount;
  dynamic? reviewCount;
  dynamic? avgReview;
  dynamic? avgRate;
  dynamic? stockQuantity;
  dynamic? rowNum;
  dynamic? wishlistId;

  ProductDetailsModel({
    this.description,
    this.modelNo,
    this.productAndModelName,
    this.modelType,
    this.newModelAmt,
    this.sellingPricePlus,
    this.sellingPriceF1,
    this.sellingPriceF2,
    this.discountPercentage,
    this.modelUrl,
    this.ramName,
    this.romName,
    this.colorName,
    this.ramId,
    this.romId,
    this.colorId,
    this.f1Plus,
    this.f1,
    this.id,
    this.ucode,
    this.sellingPrice,
    this.processor,
    this.display,
    this.rearCamera,
    this.frontCamera,
    this.battery,
    this.wishlistCount,
    this.reviewCount,
    this.avgReview,
    this.avgRate,
    this.stockQuantity,
    this.rowNum,
    this.wishlistId
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsModel(
        description: json["Description"],
        modelNo: json["ModelNo"],
        productAndModelName: json["ProductAndModelName"],
        modelType: json["ModelType"],
        newModelAmt: json["NewModelAmt"],
        sellingPricePlus: json["SellingPricePlus"],
        sellingPriceF1: json["SellingPriceF1"],
        sellingPriceF2: json["SellingPriceF2"],
        discountPercentage: json["DiscountPercentage"],
        modelUrl: json["ModelUrl"],
        ramName: json["RamName"],
        romName: json["RomName"],
        colorName: json["ColorName"],
        ramId: json["RamId"],
        romId: json["RomId"],
        colorId: json["ColorId"],
        f1Plus: json["F1_Plus"],
        f1: json["F1"],
        id: json["id"],
        ucode: json["Ucode"],
        sellingPrice: json["SellingPrice"],
        processor: json["Processor"],
        display: json["Display"],
        rearCamera: json["RearCamera"],
        frontCamera: json["FrontCamera"],
        battery: json["Battery"],
        wishlistCount: json["WishlistCount"],
        reviewCount: json["ReviewCount"],
        avgReview: json["AvgReview"],
        avgRate: json["AvgRate"],
        stockQuantity: json["StockQuantity"],
        rowNum: json["RowNum"],
        wishlistId: json["WishlistId"],
      );




  Map<String, dynamic> toJson() =>
      {
        "Description": description,
        "ModelNo": modelNo,
        "ProductAndModelName": productAndModelName,
        "ModelType": modelType,
        "NewModelAmt": newModelAmt,
        "SellingPricePlus": sellingPricePlus,
        "SellingPriceF1": sellingPriceF1,
        "SellingPriceF2": sellingPriceF2,
        "DiscountPercentage": discountPercentage,
        "ModelUrl": modelUrl,
        "RamName": ramName,
        "RomName": romName,
        "ColorName": colorName,
        "RamId": ramId,
        "RomId": romId,
        "ColorId": colorId,
        "F1_Plus": f1Plus,
        "F1": f1,
        "id": id,
        "Ucode": ucode,
        "SellingPrice": sellingPrice,
        "Processor": processor,
        "Display": display,
        "RearCamera": rearCamera,
        "FrontCamera": frontCamera,
        "Battery": battery,
        "WishlistCount": wishlistCount,
        "ReviewCount": reviewCount,
        "AvgReview": avgReview,
        "AvgRate": avgRate,
        "StockQuantity": stockQuantity,
        "RowNum": rowNum,

      };
}
