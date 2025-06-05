
import 'dart:convert';

class SearchCompareProductModel {
  final String? name;
  final double? amount;
  final String? url;
  final String? image;

  SearchCompareProductModel({
    this.name,
    this.amount,
    this.url,
    this.image,
  });

  factory SearchCompareProductModel.fromJson(Map<String, dynamic> json) {
    print('Parsing JSON: $json'); // Debug print to inspect raw JSON
    return SearchCompareProductModel(
      name: json['Name']?.toString(), // Match API's capitalized "Name"
      amount: json['Amount']?.toDouble(), // Match API's capitalized "Amount"
      url: json['Url']?.toString(), // Match API's capitalized "Url"
      image: json['Image']?.toString(), // Match API's capitalized "Image"
    );
  }

  Map<String, dynamic> toJson() => {
    'Name': name,
    'Amount': amount,
    'Url': url,
    'Image': image,
  };
}