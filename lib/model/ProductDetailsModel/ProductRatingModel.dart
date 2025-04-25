// To parse this JSON data, do
//
//     final productRatingModel = productRatingModelFromJson(jsonString);

import 'dart:convert';

List<ProductRatingModel> productRatingModelFromJson(String str) => List<ProductRatingModel>.from(json.decode(str).map((x) => ProductRatingModel.fromJson(x)));

String productRatingModelToJson(List<ProductRatingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductRatingModel {
  dynamic? rating1;
  dynamic? rating2;
  dynamic? rating3;
  dynamic? rating4;
  dynamic? rating5;

  ProductRatingModel({
    this.rating1,
    this.rating2,
    this.rating3,
    this.rating4,
    this.rating5,
  });

  factory ProductRatingModel.fromJson(Map<String, dynamic> json) => ProductRatingModel(
    rating1: json["Rating1"],
    rating2: json["Rating2"],
    rating3: json["Rating3"],
    rating4: json["Rating4"],
    rating5: json["Rating5"],
  );

  Map<String, dynamic> toJson() => {
    "Rating1": rating1,
    "Rating2": rating2,
    "Rating3": rating3,
    "Rating4": rating4,
    "Rating5": rating5,
  };
}
