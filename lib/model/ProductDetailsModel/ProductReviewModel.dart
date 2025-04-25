// To parse this JSON data, do
//
//     final productReviewModel = productReviewModelFromJson(jsonString);

import 'dart:convert';

List<ProductReviewModel> productReviewModelFromJson(String str) => List<ProductReviewModel>.from(json.decode(str).map((x) => ProductReviewModel.fromJson(x)));

String productReviewModelToJson(List<ProductReviewModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductReviewModel {
  dynamic? rating;
  String? description;
  String? createdDate;
  String? firstName;

  ProductReviewModel({
    this.rating,
    this.description,
    this.createdDate,
    this.firstName,
  });

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) => ProductReviewModel(
    rating: json["Rating"],
    description: json["Description"],
    createdDate: json["CreatedDate"],
    firstName: json["FirstName"],
  );

  Map<String, dynamic> toJson() => {
    "Rating": rating,
    "Description": description,
    "CreatedDate": createdDate,
    "FirstName": firstName,
  };
}
