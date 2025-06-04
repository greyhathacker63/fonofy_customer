// Model Class for ProductImageList
import 'dart:convert';

class ProductImageListModel {
  final String? image;

  ProductImageListModel({this.image});

  factory ProductImageListModel.fromJson(Map<String, dynamic> json) {
    return ProductImageListModel(
      image: json['Image'],
    );
  }
}

List<ProductImageListModel> productImageListModelFromJson(String str) {
  final jsonData = json.decode(str);
  return List<ProductImageListModel>.from(
    jsonData.map((item) => ProductImageListModel.fromJson(item)),
  );
}
