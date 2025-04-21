import 'dart:convert';

List<SearchCompareProductModel> searchCompareProductModelFromJson(String str) =>
    List<SearchCompareProductModel>.from(
        json.decode(str).map((x) => SearchCompareProductModel.fromJson(x)));

String searchCompareProductModelToJson(List<SearchCompareProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchCompareProductModel {
  String? modelNo;
  String? productName;
  dynamic amount;
  String? image;
  String? modelUrl;

  SearchCompareProductModel({
    this.modelNo,
    this.productName,
    this.amount,
    this.image,
    this.modelUrl,
  });

  factory SearchCompareProductModel.fromJson(Map<String, dynamic> json) => SearchCompareProductModel(
        modelNo: json["ModelNo"],
        productName: json["ProductAndModelName"],
        amount: json["Amount"],
        image: json["Image"],
        modelUrl: json["ModelUrl"],
      );

  Map<String, dynamic> toJson() => {
        "ModelNo": modelNo,
        "ProductAndModelName": productName,
        "Amount": amount,
        "Image": image,
        "ModelUrl": modelUrl,
      };
}
