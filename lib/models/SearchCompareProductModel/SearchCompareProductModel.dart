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
