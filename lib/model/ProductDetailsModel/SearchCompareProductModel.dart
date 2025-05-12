import 'dart:convert';

// List<SearchCompareProductModel> searchCompareProductModelFromJson(String str) =>
//     List<SearchCompareProductModel>.from(
//         json.decode(str).map((x) => SearchCompareProductModel.fromJson(x)));
//
// String searchCompareProductModelToJson(List<SearchCompareProductModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class SearchCompareProductModel {
//   String? modelNo;
//   String? productName;
//   dynamic amount;
//   String? image;
//   String? modelUrl;
//
//   SearchCompareProductModel({
//     this.modelNo,
//     this.productName,
//     this.amount,
//     this.image,
//     this.modelUrl,
//   });
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is SearchCompareProductModel &&
//           modelNo == other.modelNo &&
//           productName == other.productName &&
//           amount == other.amount &&
//           image == other.image &&
//           modelUrl == other.modelUrl;
//
//   @override
//   int get hashCode =>
//       modelNo.hashCode ^
//       productName.hashCode ^
//       amount.hashCode ^
//       image.hashCode ^
//       modelUrl.hashCode;
//
//   factory SearchCompareProductModel.fromJson(Map<String, dynamic> json) =>
//       SearchCompareProductModel(
//         modelNo: json["ModelNo"],
//         productName: json["ProductAndModelName"],
//         amount: json["Amount"],
//         image: json["Image"],
//         modelUrl: json["ModelUrl"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "ModelNo": modelNo,
//         "ProductAndModelName": productName,
//         "Amount": amount,
//         "Image": image,
//         "ModelUrl": modelUrl,
//       };
// }
// To parse this JSON data, do
//
//     final searchCompareProductModel = searchCompareProductModelFromJson(jsonString);

import 'dart:convert';
List<SearchCompareProductModel> searchCompareProductModelFromJson(String str) =>
    List<SearchCompareProductModel>.from(
        jsonDecode(str).map((x) => SearchCompareProductModel.fromJson(x)));

String searchCompareProductModelToJson(List<SearchCompareProductModel> data) =>
    jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchCompareProductModel {
  String? name;
  dynamic amount;
  String? url;
  String? image;

  SearchCompareProductModel({
    this.name,
    this.amount,
    this.url,
    this.image,
  });

  factory SearchCompareProductModel.fromJson(Map<String, dynamic> json) =>
      SearchCompareProductModel(
        name: json["Name"]?.toString(),
        amount: json["Amount"] is int
            ? json["Amount"]
            : int.tryParse(json["Amount"]?.toString() ?? '0'),
        url: json["Url"]?.toString(),
        image: json["Image"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Amount": amount,
    "Url": url,
    "Image": image,
  };
}