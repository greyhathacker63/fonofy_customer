import 'dart:convert';

// product_model.dart
class ProductModel {
  final String modelNo;
  final String productAndModelName;
  final String modelType;
  final double amount;
  final String image;
  final double newModelAmt;
  final double discountPercentage;
  final String modelUrl;
  final int id;
  final String ucode;
  final int wishlistCount;
  final int cartQuantity;

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
