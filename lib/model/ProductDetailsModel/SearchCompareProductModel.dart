// To parse this JSON data, do
//
//     final searchCompareProductModel = searchCompareProductModelFromJson(jsonString);

import 'dart:convert';

List<SearchCompareProductModel> searchCompareProductModelFromJson(String str) => List<SearchCompareProductModel>.from(json.decode(str).map((x) => SearchCompareProductModel.fromJson(x)));

String searchCompareProductModelToJson(List<SearchCompareProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchCompareProductModel {
  String? name;
  dynamic? amount;
  String? url;
  String? image;

  SearchCompareProductModel({
    this.name,
    this.amount,
    this.url,
    this.image,
  });

  factory SearchCompareProductModel.fromJson(Map<String, dynamic> json) => SearchCompareProductModel(
    name: json["Name"],
    amount: json["Amount"],
    url: json["Url"],
    image: json["Image"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Amount": amount,
    "Url": url,
    "Image": image,
  };
}
