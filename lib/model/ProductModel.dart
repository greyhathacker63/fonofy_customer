import 'dart:convert';

// product_model.dart
class ProductModel {
  final dynamic modelNo;
  final dynamic productAndModelName;
  final dynamic modelType;
  final dynamic amount;
  final String image;
  final dynamic newModelAmt;
  final double discountPercentage;
  final dynamic modelUrl;
  final dynamic id;
  final dynamic ucode;
  final dynamic wishlistCount;
  final dynamic cartQuantity;

  ProductModel({
    required this.modelNo,
    required this.productAndModelName,
    required this.modelType,
    required this.amount,
    required this.image,
    required this.newModelAmt,
    required this.discountPercentage,
    required this.modelUrl,
    required this.id,
    required this.ucode,
    required this.wishlistCount,
    required this.cartQuantity,
  });

  // Factory constructor to create ProductModel from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      modelNo: json["ModelNo"] ?? '',
      productAndModelName: json["ProductAndModelName"] ?? '',
      modelType: json["ModelType"] ?? '',
      amount: json["Amount"] ?? 0.0,
      image: json["Image"] ?? '',
      newModelAmt: json["NewModelAmt"] ?? 0.0,
      discountPercentage: json["DiscountPercentage"] ?? 0.0,
      modelUrl: json["ModelUrl"] ?? '',
      id: json["id"] ?? 0,
      ucode: json["Ucode"] ?? '',
      wishlistCount: json["WishlistCount"] ?? 0,
      cartQuantity: json["CartQuantity"] ?? 0,
    );
  }
}
