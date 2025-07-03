
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
    print('Parsing JSON: $json');
    return SearchCompareProductModel(
      name: json['Name']?.toString(),
      amount: json['Amount']?.toDouble(),
      url: json['Url']?.toString(),
      image: json['Image']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'Name': name,
        'Amount': amount,
        'Url': url,
        'Image': image,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchCompareProductModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          url == other.url;

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
