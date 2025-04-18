// To parse this JSON data, do
//
//     final getSearchCompareProductModel = getSearchCompareProductModelFromJson(jsonString);

import 'dart:convert';

List<GetSearchProductsModel> GetSearchProductsModelFromJson(String str) => List<GetSearchProductsModel>.from(json.decode(str).map((x) => GetSearchProductsModel.fromJson(x)));

String GetSearchProductsModelToJson(List<GetSearchProductsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSearchProductsModel {
  String? name;
  String? url;

  GetSearchProductsModel({
    this.name,
    this.url,
  });

  factory GetSearchProductsModel.fromJson(Map<String, dynamic> json) => GetSearchProductsModel(
    name: json["Name"],
    url: json["Url"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Url": url,
  };
}
