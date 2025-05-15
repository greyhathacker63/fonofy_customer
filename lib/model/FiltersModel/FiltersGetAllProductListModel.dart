// To parse this JSON data, do
//
//     final filtersGetAllProductListModel = filtersGetAllProductListModelFromJson(jsonString);

import 'dart:convert';

List<FiltersGetAllProductListModel> filtersGetAllProductListModelFromJson(String str) => List<FiltersGetAllProductListModel>.from(json.decode(str).map((x) => FiltersGetAllProductListModel.fromJson(x)));

String filtersGetAllProductListModelToJson(List<FiltersGetAllProductListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FiltersGetAllProductListModel {
  String? ramName;
  String? romName;
  String? colorName;
  String? category;
  dynamic colorId;
  dynamic ramId;
  dynamic romId;
  String? modelNo;
  String? productAndModelName;
  String? modelType;
  dynamic amount;
  String? image;
  dynamic newModelAmt;
  dynamic discountPercentage;
  String? modelUrl;
  dynamic id;
  String? ucode;
  dynamic wishlistCount;
  dynamic wishlistId;
  dynamic wishListStatus;
  dynamic cartQuantity;

  FiltersGetAllProductListModel({
    this.ramName,
    this.romName,
    this.colorName,
    this.colorId,
    this.ramId,
    this.romId,
    this.modelNo,
    this.productAndModelName,
    this.modelType,
    this.amount,
    this.image,
    this.newModelAmt,
    this.discountPercentage,
    this.modelUrl,
    this.id,
    this.ucode,
    this.wishlistCount,
    this.wishlistId,
    this.wishListStatus,
    this.cartQuantity,
    this.category,
  });

  factory FiltersGetAllProductListModel.fromJson(Map<String, dynamic> json) => FiltersGetAllProductListModel(
    ramName: json["RamName"],
    romName: json["RomName"],
    colorName: json["ColorName"],
    colorId: json["ColorId"],
    ramId: json["RamId"],
    romId: json["RomId"],
    modelNo: json["ModelNo"],
    productAndModelName: json["ProductAndModelName"],
    modelType: json["ModelType"],
    amount: json["Amount"],
    image: json["Image"],
    newModelAmt: json["NewModelAmt"],
    discountPercentage: json["DiscountPercentage"],
    modelUrl: json["ModelUrl"],
    id: json["id"],
    ucode: json["Ucode"],
    wishlistCount: json["WishlistCount"],
    wishlistId: json["WishlistId"],
    wishListStatus: json["WishListStatus"],
    cartQuantity: json["CartQuantity"],
  );

  Map<String, dynamic> toJson() => {
    "RamName": ramName,
    "RomName": romName,
    "ColorName": colorName,
    "ColorId": colorId,
    "RamId": ramId,
    "RomId": romId,
    "ModelNo": modelNo,
    "ProductAndModelName": productAndModelName,
    "ModelType": modelType,
    "Amount": amount,
    "Image": image,
    "NewModelAmt": newModelAmt,
    "DiscountPercentage": discountPercentage,
    "ModelUrl": modelUrl,
    "id": id,
    "Ucode": ucode,
    "WishlistCount": wishlistCount,
    "WishlistId": wishlistId,
    "WishListStatus": wishListStatus,
    "CartQuantity": cartQuantity,
  };
}
