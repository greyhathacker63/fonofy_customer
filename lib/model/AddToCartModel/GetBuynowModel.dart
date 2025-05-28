// To parse this JSON data, do
//
//     final getBuynowModel = getBuynowModelFromJson(jsonString);

import 'dart:convert';

List<GetBuyNowModel> getBuyNowModelFromJson(String str) => List<GetBuyNowModel>.from(json.decode(str).map((x) => GetBuyNowModel.fromJson(x)));

String getBuyNowModelToJson(List<GetBuyNowModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetBuyNowModel {
  dynamic cartId;
  String? productName;
  dynamic productId;
  dynamic f2;
  String? ramName;
  String? romName;
  String? colorName;
  String? ucode;
  String? url;
  String? productImage;
  dynamic stockQuantity;
  dynamic ramId;
  dynamic romId;
  dynamic colorId;
  dynamic quantity;
  dynamic price;
  dynamic mrp;
  dynamic discount;
  dynamic discountAmount;
  dynamic sellingPrice;
  dynamic totalSellingPrice;
  dynamic totalPrice;
  dynamic totalMrp;
  dynamic totalDiscount;

  GetBuyNowModel({
    this.cartId,
    this.productName,
    this.productId,
    this.f2,
    this.ramName,
    this.romName,
    this.colorName,
    this.ucode,
    this.url,
    this.productImage,
    this.stockQuantity,
    this.ramId,
    this.romId,
    this.colorId,
    this.quantity,
    this.price,
    this.mrp,
    this.discount,
    this.discountAmount,
    this.sellingPrice,
    this.totalSellingPrice,
    this.totalPrice,
    this.totalMrp,
    this.totalDiscount,
  });

  factory GetBuyNowModel.fromJson(Map<String, dynamic> json) => GetBuyNowModel(
    cartId: json["CartId"],
    productName: json["ProductName"],
    productId: json["ProductId"],
    f2: json["F2"],
    ramName: json["RamName"],
    romName: json["RomName"],
    colorName: json["ColorName"],
    ucode: json["Ucode"],
    url: json["URL"],
    productImage: json["ProductImage"],
    stockQuantity: json["StockQuantity"],
    ramId: json["RamId"],
    romId: json["RomId"],
    colorId: json["ColorId"],
    quantity: json["Quantity"],
    price: json["Price"],
    mrp: json["MRP"],
    discount: json["Discount"],
    discountAmount: json["DiscountAmount"],
    sellingPrice: json["SellingPrice"],
    totalSellingPrice: json["TotalSellingPrice"],
    totalPrice: json["TotalPrice"],
    totalMrp: json["TotalMRP"],
    totalDiscount: json["TotalDiscount"],
  );


  Map<String, dynamic> toJson() => {
    "CartId": cartId,
    "ProductName": productName,
    "ProductId": productId,
    "F2": f2,
    "RamName": ramName,
    "RomName": romName,
    "ColorName": colorName,
    "Ucode": ucode,
    "URL": url,
    "ProductImage": productImage,
    "StockQuantity": stockQuantity,
    "RamId": ramId,
    "RomId": romId,
    "ColorId": colorId,
    "Quantity": quantity,
    "Price": price,
    "MRP": mrp,
    "Discount": discount,
    "DiscountAmount": discountAmount,
    "SellingPrice": sellingPrice,
    "TotalSellingPrice": totalSellingPrice,
    "TotalPrice": totalPrice,
    "TotalMRP": totalMrp,
    "TotalDiscount": totalDiscount,
  };

 }
